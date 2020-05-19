import json

fin = open('nodes.json', 'rt', encoding = 'utf-8-sig')

data = json.load(fin)

fin.close()

communities = {}
for d in data:
    if d['community'] not in communities:
        communities[d['community']] = 1
    else:
        communities[d['community']] += 1
# print(communities)

fout = open('labeling.cypher', 'wt')
for d in data:
    nodeId = d['id']
    community = d['community']
    fout.write("MATCH (node { code: '" + str(nodeId) + "'} ) ")
    if communities[community] >= 10:
        fout.write("SET node:c" + str(community) + "\n")
    else:
        fout.write("DETACH DELETE node\n")
    fout.write("WITH 1 as dummy\n")
fout.write("MATCH(n) RETURN(n)")
fout.close()
