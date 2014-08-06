require! <[ http request url ]>

write-json-response = (res, obj) ->
  res.write JSON.stringify obj, \utf8, 0
  res.end!

termcount = {}

port = process.env.PORT || 3000
http.createServer !(req, res) ->
  link = url.parse req.url, true
  if req.method == "POST"
    tc = {}
    for term in link.query.q.split(" ")
      termcount[term] ||= 0
      termcount[term] += 1
      tc[term] = termcount[term]
    write-json-response res, tc
  else
      write-json-response res, termcount
.listen port

console.log "> http server has started on port #port";
