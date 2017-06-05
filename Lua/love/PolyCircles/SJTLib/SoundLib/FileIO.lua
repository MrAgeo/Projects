FileIO = {}
local F = class() -- File Class

function F:init(filename)
    self.file, errstr = love.filesystem.newFile(filename)
    self.content = ""
    if errstr then
        print("An Error occurred during creating the file: "..errstr)
    end
end


function F:append(data)
    local ok, err = self.file:open('a')
    if ok then
        local success, err = self.file:write(data)
        if success then
            if not self.file:close() then
                print("An Error occurred during closing the file")
            end
        else
            print("An Error occurred during the file writing: "..err)
        end
    else
        print("An Error occurred during opening the file: "..err)
    end
end


function F:write(data)
    local ok, err = self.file:open('w')
    if ok then
        local success, err = self.file:write(data)
        if success then
            if not self.file:close() then
                print("An Error occurred during closing the file")
            end
        else
            print("An Error occurred during the file writing: "..err)
        end
    else
        print("An Error occurred during opening the file: "..err)
    end
end

function F:read(bytes)
    local ok, err = self.file:open('r')
    local content, size
    if ok then
        content, size = self.file:read(bytes)
    else
        print("An Error occurred during opening the file: "..err)
    end
    if not self.file:close() then
        print("An Error occurred during closing the file")
    end
    return content, size
end


function F:getByte(byteNum)
    local ok, err = self.file:open('r')
    if ok then
        local content, size = self.file:read(byteNum)
        content:byte(byteNum)
    else
        print("An Error occurred during opening the file: "..err)
    end
    if not self.file:close() then
        print("An Error occurred during closing the file")
    end
    return content
end


function FileIO.newFile(filename)
    return F(filename)
end