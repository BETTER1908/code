--bok,hfile = lock_file(filename)
--bok = unlock_file(hfile)
-- hub_start("127.0.0.1",80,10)
hub_start("192.168.5.232",80,10)
--content = hub_connect("202.89.233.101",80)
cs = {}


function get_filename_list(folder,recursion)
	local cmd = 'dir "'..folder..'" '..(recursion and '/s' or '')..' /b';
	local files, popen = {}, io.popen;
	for filename in popen(cmd):lines() do
		files[filename] = true
	end
	for k,v in pairs(files) do
		trace_out(k..'\n')
	end
	return files;
end

function accept(content,str)
trace_out("accept(): "..str.."\n")	
	cs[content] = true
	local files = get_filename_list("D:/Projects/")
	html = "</html><head></head> <body>Projects:\n"
	for k,v in pairs(files) do
		html = html.."["..k.."]\n"
	end
	html = html.."</body></html>\n"
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

function recv(content,str)
	trace_out("recv(): "..str.."\n")	
	
	hub_send(content,"i am server\n")	
end

function do_recv(content,str)
	redirect(2,0,"recv",content,str)
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

