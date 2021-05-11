$chart = New-ExcelChart -Title Usage -ChartType BarClustered -Header 'Usage' -XRange 'Usage[Name]' -YRange @('Usage[Mem Usage( % )]','Usage[CPU Usage( % )]')

$vm = Get-Content "C:\Users\tkarthi1\Desktop\vm.txt"

Get-VM $vm |

Select Name,

    @{N="Mem Usage( % )" ; E={ $_ | Get-Stat -Stat mem.usage.average -MaxSamples 1 -Start (Get-Date).AddMonths(-6) }} ,

    @{N="CPU Usage( % )" ;E={ $_ | Get-Stat -Stat cpu.usage.average -MaxSamples 1 -Start (Get-Date).AddMonths(-6) }} |

Export-Excel -Path "C:\Users\tkarthi1\Desktop\report.xlsx" -WorkSheetname Usage -TableName Usage -ExcelChartDefinition $chart -Show