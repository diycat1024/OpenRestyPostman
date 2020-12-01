#!/bin/bash/lua

postman = {}

local http = require("resty.http")

function postman.httpPost(req_uri, req_body)
    local httpc = http.new()
    httpc:set_timeouts(5000, 5000, 5000)
    httpc:set_keepalive(6000, 1000)
    local res, err = httpc:request_uri(req_uri, {
        method = "POST",
        headers = {
            ["Content-type"] = "application/json;charset=utf8",
        },
        body = req_body
    })
    if not res then
        local body = "failed to request: " .. err
        ngx.say(body)
        return body
    end
    ngx.status = res.status
    ngx.say("<td>")
    ngx.say(res.body)
    ngx.say("</td>")

    httpc:close()
    return res.body
end
return postman