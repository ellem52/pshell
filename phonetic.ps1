# NATO Phonetic Alphabet Converter
# Converts letters and numerals to NATO phonetic equivalents

$nato = @{
    'A' = 'Alpha';   'B' = 'Bravo';    'C' = 'Charlie'; 'D' = 'Delta';
    'E' = 'Echo';    'F' = 'Foxtrot';  'G' = 'Golf';    'H' = 'Hotel';
    'I' = 'India';   'J' = 'Juliet';   'K' = 'Kilo';    'L' = 'Lima';
    'M' = 'Mike';    'N' = 'November'; 'O' = 'Oscar';   'P' = 'Papa';
    'Q' = 'Quebec';  'R' = 'Romeo';    'S' = 'Sierra';  'T' = 'Tango';
    'U' = 'Uniform'; 'V' = 'Victor';   'W' = 'Whiskey'; 'X' = 'X-ray';
    'Y' = 'Yankee';  'Z' = 'Zulu';
    '0' = 'Zero';    '1' = 'One';      '2' = 'Two';     '3' = 'Tree';
    '4' = 'Four';    '5' = 'Fife';     '6' = 'Six';     '7' = 'Seven';
    '8' = 'Eight';   '9' = 'Niner'
}

function Convert-ToNato {
    param([string]$Text)

    $results = foreach ($char in [char[]]$Text) {
        $key = "$char".ToUpper()
        if ($key -eq ' ') {
            ''  # blank line between words
        } elseif ($nato.ContainsKey($key)) {
            '{0,-10} = {1}' -f $char, $nato[$key]
        } else {
            '{0,-10} = (not converted)' -f $char
        }
    }
    $results
}

do {
    $input = Read-Host "`nEnter text to convert"

    Write-Host "`nNATO Phonetic:`n" -ForegroundColor Cyan
    Convert-ToNato -Text $input | ForEach-Object { Write-Host $_ }

    $continue = Read-Host "`nConvert more text? (Y/N)"
} while ($continue -match '^[Yy]')

Write-Host "`nDone." -ForegroundColor Green
