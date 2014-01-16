console.log \hihi
main = ($scope, $http) ->
  console.log \blah
  $http.get \index.json .success (data) ->
    console.log data
    ret = []
    c = 0
    for k of data
      console.log k
      for it in data[k]items
        c++
        link = it.formattedUrl
        if not link => continue
        if link.search(/g0v\.json$/) >=0 => 
          obj = {link} # : it.formattedUrl}
          ret.push obj
    $scope.links = ret
    $scope.count = ret.length
    $scope.tcount = c
