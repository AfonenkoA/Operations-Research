function Header(el)
    if el.level == 1 then
        return el:walk {
            Str = function(el)
            return pandoc.Str("Практическая работа: " .. el.text)
            end
        }
    end
end


return {
        { Header = Header }
}
