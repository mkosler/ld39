return {
    add = function (t, ...)
        for _,o in pairs{...} do
            table.insert(t, o)
        end

        return ...
    end,
    map = function (t, f, ...)
        for _,o in pairs(t) do
            if type(f) == 'string' then
                if o[f] ~= nil then o[f](o, ...) end
            elseif type(f) == 'function' then
                f(o, ...)
            else
                error(string.format('Cannot handle type given (%s).', type(f)))
            end
        end
    end
}