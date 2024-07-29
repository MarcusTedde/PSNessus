function Convert-UnixTimestampToDateTime {
    param(
        [Parameter(Mandatory=$true)]
        [int64]
        $UnixTimestamp
    )

    $epochStart = Get-Date -Year 1970 -Month 1 -Day 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0
    $dateTime = $epochStart.AddSeconds($UnixTimestamp)

    return $dateTime
}
