require! <[fs]>

data = JSON.parse(fs.readFileSync \final.json .toString!)

hash = {}

for user of data
  for name of data[user]
    d = data[user][name]
    obj = {}
    obj.contributors = for cont in d.data
      total: cont.total, user: cont.author.login
    obj.commits = obj.contributors.reduce ((a,b)->a + b.total), 0
    obj.name = d.meta.name_zh or d.meta.name or name
    obj.homepage = d.meta.homepage
    obj.repository = d.meta.{}repository.url or ""
    hash.{}[user][name] = obj

fs.writeFileSync \simple.json, JSON.stringify hash
