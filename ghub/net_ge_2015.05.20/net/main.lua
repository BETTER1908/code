--bok,hfile = lock_file(filename)
--bok = unlock_file(hfile)
-- hub_start("127.0.0.1",80,10)
hub_start("192.168.5.168",80,10)
--content = hub_connect("202.89.233.101",80)
cs = {}

function accept(content,str)
	cs[content] = true
	html = "</html><head></head> <body>hello world!</body></html>\n"
	head = "HTTP/1.1 200 ok\nContent-Type: text/html;charset=gb2312\n" .. "Content-Length: " .. string.len(html) .. "\n\n"
	hub_send(content,head .. html)	
end

function do_accept(content,str)
	--ip,port = hub_addr(content)
	--trace_out("thread : " .. thread_num .. "\n")
	--trace_out("lua accept at " ..ip .. ":"  ..port .."  info:" .. str .. "\n")
	--hub_send(content,"welcome!")
	--trace_out("thread:" .. thread_num .. " in thread\n")
	redirect(2,0,"accept",content,str)
end

function do_recv(content,str)
	redirect(2,0,"recv",content,str)
end

function recv(content,str)
	trace_out("recv:main.lua\n")	
end

function socket_quit(content)
	cs[content] = nil
end

--[[	
function test(a,b)
	local t ={}
	t[1] = a+b
	t[2] = a-b
	return t	
end
--]]
function on_quit()
  for k,v in cs do
		remove_content(k)
	end	
end

