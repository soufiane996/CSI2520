
import json

data = json.load(open('wading-pools.json','r',encoding='utf8'))
pools = []
for pool in data["features"]:
    temporary_pool = {
        "name": pool["properties"]["NAME"].split('- ')[1],
        "lat": pool["geometry"]["coordinates"][0],
        "lon": pool["geometry"]["coordinates"][1]
    }
    pools.append(temporary_pool)



with open('input.txt','w', encoding='utf8') as outfile:
    for pool in pools:
        outfile.write(pool["name"]+',')
        outfile.write(str(pool["lat"])+',')
        outfile.write(str(pool["lon"])+'\n')
