function callHud(code)
 local chunk = loadstring(code)
 if(chunk) then
  return chunk()
 end
end