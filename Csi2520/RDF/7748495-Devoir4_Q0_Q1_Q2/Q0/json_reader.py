import json
file= open('wading-pools.json','r', encoding='utf8')
out= open('out.txt', 'w', encoding='utf8')
data = json.load(file)
for d in data['features']:
    temp = d['properties']['NAME']
    out.write(temp)
    out.write(', ')
    out.write(str(d['geometry']['coordinates'][0]))
    out.write(', ')
    out.write(str(d['geometry']['coordinates'][1]))
