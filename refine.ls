require! <[fs request]>

data = JSON.parse(fs.readFileSync \output.json .toString!)
hash = {}

req = do
  method: \GET
  headers: do
    "User-Agent": "Mozilla/5.0 (Windows NT 6.1; WOW64)"

dump = ->
  for user of hash => for name of hash[user] => if hash[user][name]==0 => return
  console.log "dumping..."
  fs.writeFileSync \final.json JSON.stringify(hash)
for let user of data
  for let name of data[user]
    hash.{}[user][name] = 0
    req.url = "http://raw.github.com/#{user}/#{name}/master/g0v.json"
    request req, (e,r,b) ->
      if not (d = try JSON.parse b) =>
        console.log "parse error #user/#name"
        delete hash[user][name]
        return
      hash[user][name] = {data: data[user][name], meta: d}
      console.log "#user #name : #{d.name}"
      dump!
