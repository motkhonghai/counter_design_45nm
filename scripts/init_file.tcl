#!/usr/bin/tclsh

proc gen_lef_input {path} {
	set s1 "set init_lef_files {\\ \n"
	set files [glob -nocomplain -directory $path *]
	set count 0
	foreach f $files {
		append s1 "$f \\ \n"
		incr count
	}
	append s1 "}"
	#puts $s1
	set out_file ""
	append out_file "$path/all_lef_file.tcl"
	set fw [open $out_file w]
	puts $fw $s1
	puts "==>FINISHED: Your file has benn saved to $out_file (Folder has $count files)"
	set init_lef_file $out_file
	close $fw
}
proc extract_mmmc_lib {path mode} {
    # Khởi đầu chuỗi bằng dấu mở ngoặc nhọn và xuống dòng
    set s1 "\{\n"
    set files [glob -nocomplain -directory $path *]
    set count 0
    set pattern "*$mode*"
    
    foreach f $files {
        if {[string match $pattern $f]} {
            # Thêm khoảng trắng (thụt lề) trước đường dẫn và xuống dòng ở cuối
            append s1 "    $f\n"
            incr count
        }
    }
    
    # Đóng ngoặc nhọn
    append s1 "\}"
    
    if {$count == 0} {
        puts "Your mode is invalid (fast/slow/typ): $mode"
        return 0
    }
    
    puts "===================BEGIN======================="
    puts "create_library_set -name wcl_$mode -timing $s1"
    puts "=====================END======================="
}
