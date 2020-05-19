#!/usr/bin/env python

# CS3810
# Principles of Database Systems
# Date: 10/27/19
# Author: Eryn Kelsey-Adkins
# Description: Database Assignment 2

import pandas
import pymysql
import databaseconfig as cfg

# note pymysql depends on the cryptography module; ensure it is installed

# read data from file
data = pandas.read_csv('Inpatient_Prospective_Payment_System__IPPS__Provider_Summary_for_the_Top_100_Diagnosis'
                       '-Related_Groups__DRG__-_FY2011.csv')

# create drg data frame
drg = data['DRG Definition'].str.split(" - ", n=1, expand=True)
# replace DRG Definition with code (for foreign key)
data['DRG Definition'] = drg[0]
drg.drop_duplicates(inplace=True)

# create referral region data frame
rr = data[['Hospital Referral Region Description']].copy()
rr.drop_duplicates(inplace=True)
rr['id'] = range(len(rr))
data['Hospital Referral Region Description'] = data['Hospital Referral Region Description'].map(
    rr.set_index('Hospital Referral Region Description')['id']).fillna(data['Hospital Referral Region Description'])
new_rr = rr['Hospital Referral Region Description'].str.split(" - ", n=1, expand=True)
rr.drop(columns=['Hospital Referral Region Description'], inplace=True)
rr['state'] = new_rr[0]
rr['city'] = new_rr[1]
del new_rr

# create provider data frame
provider = data[['Provider Id', 'Provider Name', 'Provider Street Address',
                 'Provider City', 'Provider State', 'Provider Zip Code', 'Hospital Referral Region Description']].copy()
provider.drop_duplicates(inplace=True)

# create charges data frame
charges = data[[' Total Discharges ', ' Average Covered Charges ', ' Average Total Payments ',
                'Average Medicare Payments', 'DRG Definition', 'Provider Id']].copy()
charges['id'] = range(len(charges))

# delete original dataframe
del data

# connect to the database
conn = pymysql.connect(cfg.mysql['server'], cfg.mysql['user'], cfg.mysql['password'], cfg.mysql['database'])
if conn:
    print('Connection to MySQL database', cfg.mysql['database'], 'was successful!')
    print('Loading data from file')
    print('This will take a few moments')

with conn:
    cur = conn.cursor()

    # load values into DiagnosisGroups
    for index, row in drg.iterrows():
        cur.execute("INSERT INTO DiagnosisGroups(code, description) VALUES (%s, %s);",
                    (row[0], row[1]))
        conn.commit()

    # load values into ReferralRegions
    for index, row in rr.iterrows():
        cur.execute("INSERT INTO ReferralRegions(id, state, city) VALUES (%s, %s, %s)",
                    (row['id'], row['state'], row['city']))
        conn.commit()

    # load values into Providers
    for index, row in provider.iterrows():
        cur.execute("INSERT INTO Providers(id, name, address, city, state,"
                    "zip, regionId) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                    (row['Provider Id'], row['Provider Name'],
                     row['Provider Street Address'], row['Provider City'],
                     row['Provider State'], row['Provider Zip Code'],
                     row['Hospital Referral Region Description']))
        conn.commit()

    # load values into Charges
    for index, row in charges.iterrows():
        cur.execute("INSERT INTO Charges(id, totalDischarges, averageCoveredCharges, "
                    "averageTotalPayments, averageMedicarePayments, diagnosisCode, "
                    "providerId) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                    (row['id'], row[' Total Discharges '], row[' Average Covered Charges '],
                     row[' Average Total Payments '], row['Average Medicare Payments'],
                     row['DRG Definition'], row['Provider Id']))
        conn.commit()

    cur.close()

# delete dataframes
del drg
del rr
del provider
del charges

# close the database connection
print('Tables loaded successfully')
print('Connection to MySQL database', cfg.mysql['database'], 'was closed')
conn.close()
