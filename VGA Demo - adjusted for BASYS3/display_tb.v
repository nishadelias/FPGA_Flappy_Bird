use ieee.std_logic_textio.all;
use std.textio.all;

process (clk)
file file_pointer: text is out "write.txt";
variable line_el: line;
begin
if rising_edge(clk) then
-- Write the time
write(line_el, now); -- write the line.
write(line_el, ":"); -- write the line.

    -- Write the hsync
    write(line_el, " ");
    write(line_el, hsync); -- write the line.

    -- Write the vsync
    write(line_el, " ");
    write(line_el, vsync); -- write the line.

    -- Write the red
    write(line_el, " ");
    write(line_el, Red); -- write the line.

    -- Write the green
    write(line_el, " ");
    write(line_el, Green); -- write the line.

    -- Write the blue
    write(line_el, " ");
    write(line_el, Blue); -- write the line.

    -- write the contents into the file.
    writeline(file_pointer, line_el);

end if;
end process;
