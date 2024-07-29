---
Module Name: PSNessusAPI
online version:
schema: 2.0.0
---

# Convert-UnixTimestampToDateTime

## SYNOPSIS
Converts a Unix timestamp into a DateTime object.

## SYNTAX

```
Convert-UnixTimestampToDateTime [-UnixTimestamp] <Int64> [<CommonParameters>]
```

## DESCRIPTION
This cmdlet converts a Unix timestamp (the number of seconds that have elapsed since January 1, 1970, 00:00:00 UTC) into a .NET DateTime object. This is useful for converting Unix timestamps into a more readable date and time format in PowerShell scripts.

## EXAMPLES

### EXAMPLE 1
```
Convert-UnixTimestampToDateTime -UnixTimestamp 1609459200
```
This example converts the Unix timestamp `1609459200` into a DateTime object, returning the corresponding date and time value, which represents the start of January 1, 2021, in UTC.

## PARAMETERS

### -UnixTimestamp
Specifies the Unix timestamp to be converted. This parameter is mandatory.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: 
Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

None. You cannot pipe objects to this cmdlet.

## OUTPUTS

### System.DateTime
This cmdlet returns a System.DateTime object representing the date and time equivalent of the provided Unix timestamp.

## NOTES
- Version: 0.0.1
- Author: Marcus Tedde
- Purpose/Change: Initial development of the cmdlet for converting Unix timestamps to DateTime objects.

## RELATED LINKS
