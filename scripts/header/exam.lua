function Header(el)
    if el.level == 1 then
      el.content:insert(1,pandoc.Str("Проверочная работа: "))
      return el
    end
end


return {
        { Header = Header }
}
