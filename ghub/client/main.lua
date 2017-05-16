-- hub_start("127.0.0.1",80,10)
content = hub_connect("192.168.5.232",80)
if content then hub_send(content,"Hello Connect\n") end
if content then hub_send(content,"Hello 2\n") end

function recv(content,str)
	trace_out("recv(): "..str.."\n")	
end
function do_recv(content,str)redirect(2,0,"recv",content,str)end

function socket_quit(content)
	content = nil;
end

function on_quit()
	remove_content(content)
end

