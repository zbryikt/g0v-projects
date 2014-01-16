require! <[fs request]>

buf = fs.readFileSync \index.json
data = JSON.parse buf.toString!

opt = do
  client_id:     \ab2376373fe2da1ccb17
  client_secret: \6560c859d46e79f00dade30999ee62ca5052437d

req = do
  method: \GET
  headers: do
    "User-Agent": "Mozilla/5.0 (Windows NT 6.1; WOW64)"
  qs: opt

prjs = {}
[c1,c2] = [0,0]

for k,v of data
  for it in v.items
    if not (link = it.formattedUrl) => continue
    ret = /github.com\/([^\/]+)\/([^\/]+)\/blob\/master\/g0v.json/.exec link
    if not ret => continue
    c1++
for k,v of data
  for it in v.items
    if not (link = it.formattedUrl) => continue
    ret = /github.com\/([^\/]+)\/([^\/]+)\/blob\/master\/g0v.json/.exec link
    if not ret => continue
    ((user,name) ->
      req.url = "https://api.github.com/repos/#{user}/#{name}/stats/contributors"
      request req, (e,r,b) ->
        commits = 0
        d = JSON.parse b
        prjs.{}[user][name] = d
        c2++
        console.log c1, c2
        if c2==c1 => fs.writeFileSync \output.json, JSON.stringify(prjs)
    ) ret.1, ret.2
