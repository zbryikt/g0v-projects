// Generated by LiveScript 1.2.0
var request, fs, url, opt, req, hash, i$, i;
request = require('request');
fs = require('fs');
url = 'https://www.googleapis.com/customsearch/v1';
opt = {
  key: 'AIzaSyDCAVShr9x5wFP3nF7Q5XsRhryXrwR68wA',
  cx: '015145480824799376887:pxqqfgz6ru4',
  q: 'g0v.json',
  start: '1'
};
req = {
  uri: url,
  method: 'GET',
  qs: opt
};
hash = {};
for (i$ = 1; i$ <= 801; i$ += 10) {
  i = i$;
  fn$(i);
}
function fn$(idx){
  req.qs.start = idx;
  return request(req, function(e, r, b){
    var k;
    if (!e && r.statusCode === 200) {
      hash[idx] = JSON.parse(b);
      if ((function(){
        var results$ = [];
        for (k in hash) {
          results$.push(k);
        }
        return results$;
      }()).length === 10) {
        return fs.writeFileSync('final', JSON.stringify(hash));
      }
    }
  });
}