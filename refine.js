// Generated by LiveScript 1.2.0
var fs, request, data, hash, req, dump, i$;
fs = require('fs');
request = require('request');
data = JSON.parse(fs.readFileSync('output.json').toString());
hash = {};
req = {
  method: 'GET',
  headers: {
    "User-Agent": "Mozilla/5.0 (Windows NT 6.1; WOW64)"
  }
};
dump = function(){
  var user, name;
  for (user in hash) {
    for (name in hash[user]) {
      if (hash[user][name] === 0) {
        return;
      }
    }
  }
  console.log("dumping...");
  return fs.writeFileSync('final.jsonm', JSON.stringify(hash));
};
for (i$ in data) {
  (fn$.call(this, i$));
}
function fn$(user){
  var i$;
  for (i$ in data[user]) {
    (fn$.call(this, i$));
  }
  function fn$(name){
    (hash[user] || (hash[user] = {}))[name] = 0;
    req.url = "http://raw.github.com/" + user + "/" + name + "/master/g0v.json";
    request(req, function(e, r, b){
      var d;
      if (!(d = (function(){
        try {
          return JSON.parse(b);
        } catch (e$) {}
      }()))) {
        console.log("parse error " + user + "/" + name);
        delete hash[user][name];
        return;
      }
      hash[user][name] = {
        data: data[user][name],
        meta: d
      };
      console.log(user + " " + name + " : " + d.name);
      return dump();
    });
  }
}