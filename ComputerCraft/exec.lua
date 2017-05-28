function main(args)
    p=""
    a={}
    for i,v in ipairs(args) do
        if i == 1 then
            p = v
        else
            table.insert(a, v)
        end
    end
    shell.run(p, unpack(a))
end

main({...})
