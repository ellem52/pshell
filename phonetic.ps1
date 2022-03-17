# Danny's rewrite of phonetic.pl 03162022
do {
$str = 	read-host "Enter letters & numbers"
	write-host "`nPhonetically: `n"

foreach ($char in [char[]]$str) {
    switch ($char) {
        a {"alpha"}
        b {"bravo"}
        c {"charlie"}
        d {"delta"}
        e {"echo"}
        f {"foxtrot"}
        g {"golf"}
        h {"hotel"}
        i {"india"}
        j {"juliet"}
        k {"kilo"}
        l {"lima"}
        m {"mike"}
        n {"november"}
        o {"oscar"}
        p {"papa"}
        q {"quebec"}
        r {"romeo"}
        s {"sierra"}
        t {"tango"}
        u {"uniform"}
        v {"victor"}
        w {"whiskey"}
        x {"xray"}
        y {"yankee"}
        z {"zulu"}
        1 {"one"}
        2 {"two"}
        3 {"tree"}
        4 {"four"}
        5 {"fife"}
        6 {"six"}
        7 {"seven"}
        8 {"eight"}
        9 {"niner"}
        0 {"zero"}
        " " {"`n"}

        default { $char }
     }
}

# pause

$continue = read-host "`nWould you like to enter more Letters & Numbers: Y or N"
	    }
while ($continue -eq "y" -or $continue -eq "yes")
