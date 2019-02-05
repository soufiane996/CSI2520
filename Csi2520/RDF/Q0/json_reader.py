
import json

data = json.load(open('wading-pools.json','r',encoding='utf8'))

pools = []

# Get the pool data into a nice list
for pool in data["features"]:
    temp_pool = {
        "name": pool["properties"]["NAME"].split('- ')[1],
        "lat": pool["geometry"]["coordinates"][0],
        "lon": pool["geometry"]["coordinates"][1]
    }
    pools.append(temp_pool)



with open('input_for_scheme.txt','w', encoding='utf8') as outfile:
    for pool in pools:
        outfile.write(pool["name"]+',')
        outfile.write(str(pool["lat"])+',')
        outfile.write(str(pool["lon"])+'\n')
