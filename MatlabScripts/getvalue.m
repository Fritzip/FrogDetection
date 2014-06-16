function pourc = getvalue(h)
    level1 = get(h,'Children');
    level2 = get(level1,'Children');
    test = get(level2(2),'xdata');
    pourc = test(2)/100;
end