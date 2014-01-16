require! <[request fs]>

#wget -O output "https://www.googleapis.com/customsearch/v1?key=AIzaSyDCAVShr9x5wFP3nF7Q5XsRhryXrwR68wA&cx=015145480824799376887:pxqqfgz6ru4&q=g0v.json&start=8"

url = \https://www.googleapis.com/customsearch/v1
opt = do
  key:   \AIzaSyDCAVShr9x5wFP3nF7Q5XsRhryXrwR68wA
  cx:    \015145480824799376887:pxqqfgz6ru4
  q:     \g0v.json
  start: \1


req = do
  uri: url
  method: \GET
  qs: opt

hash = {}

for i from 1 to 801 by 10
  ((idx) ->
    req.qs.start = idx
    request req, (e,r,b) ->
      if !e and r.status-code ==  200 =>
        hash[idx] = JSON.parse b
        if [k for k of hash]length==10 =>
          fs.writeFileSync \final, JSON.stringify(hash)
  ) i
