
   Get-ChildItem -Path HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |

   Get-ItemProperty |

   Sort-Object -Property DisplayName |

   Select-Object -Property DisplayName, DisplayVersion, InstallLocation