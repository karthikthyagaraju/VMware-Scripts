﻿$file = import-csv "C:\Users\tkarthi1\Desktop\bulkmail.csv"
$link = "<a href='http://riskmanagement.unisys.com/selfhelp/howto/FreeUpDiskSpace.htm'>How to free-up space on your hard disk</a>"
$comp = $null
$comp1 = $null
$Array = @()
$Array = $file 
$len = $Array.Count
for($i=0; $i -le $len; $i++)

    {
      
     if($Array[$i].UserName -eq $Array[$i+1].UserName)
        {
        $comp1 = $Array[$i].Name
        $comp = (-join ("$comp1", ",", " $comp "))
        #echo $comp

        }

    else
        {
            $comp1 = $Array[$i].Name
            $comp = (-join ("$comp1", ",", " $comp"))
           $email =  $Array[$i].UserName
           $SCCMImage = Get-Content "C:\Users\tkarthi1\Desktop\html\sccm.jpg"
           $user = $email.split(".")
           $User1 = $user[0]
           $User1 = $User1.substring(0,1).toupper()+$User1.substring(1).tolower()
           $body = @"
           <html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns:m="http://schemas.microsoft.com/office/2004/12/omml"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 15">
<meta name=Originator content="Microsoft Word 15">
<link rel=File-List
href="Technology%20Infrastructure%20Services_files/filelist.xml">
<link rel=Edit-Time-Data
href="Technology%20Infrastructure%20Services_files/editdata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Thyagaraju, Karthik</o:Author>
  <o:LastAuthor>Thyagaraju, Karthik</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>4</o:TotalTime>
  <o:Created>2020-02-26T11:53:00Z</o:Created>
  <o:LastSaved>2020-02-26T14:40:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>274</o:Words>
  <o:Characters>1566</o:Characters>
  <o:Lines>13</o:Lines>
  <o:Paragraphs>3</o:Paragraphs>
  <o:CharactersWithSpaces>1837</o:CharactersWithSpaces>
  <o:Version>16.00</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<link rel=themeData
href="Technology%20Infrastructure%20Services_files/themedata.thmx">
<link rel=colorSchemeMapping
href="Technology%20Infrastructure%20Services_files/colorschememapping.xml">
<!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:TrackMoves>false</w:TrackMoves>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="&#45;-"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="false"
  DefSemiHidden="false" DefQFormat="false" DefPriority="99"
  LatentStyleCount="375">
  <w:LsdException Locked="false" Priority="0" QFormat="true" Name="Normal"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 1"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 5"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 6"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 7"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 8"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 9"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 1"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 2"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 3"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 4"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 5"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 6"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 7"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 8"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="header"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footer"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index heading"/>
  <w:LsdException Locked="false" Priority="35" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="caption"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of figures"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope return"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="line number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="page number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of authorities"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="macro"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toa heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 5"/>
  <w:LsdException Locked="false" Priority="10" QFormat="true" Name="Title"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Closing"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Signature"/>
  <w:LsdException Locked="false" Priority="1" SemiHidden="true"
   UnhideWhenUsed="true" Name="Default Paragraph Font"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Message Header"/>
  <w:LsdException Locked="false" Priority="11" QFormat="true" Name="Subtitle"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Salutation"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Date"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Note Heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Block Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="FollowedHyperlink"/>
  <w:LsdException Locked="false" Priority="22" QFormat="true" Name="Strong"/>
  <w:LsdException Locked="false" Priority="20" QFormat="true" Name="Emphasis"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Document Map"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Plain Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="E-mail Signature"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Top of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Bottom of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal (Web)"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Acronym"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Cite"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Code"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Definition"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Keyboard"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Preformatted"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Sample"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Typewriter"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Variable"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Table"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation subject"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="No List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Contemporary"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Elegant"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Professional"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Balloon Text"/>
  <w:LsdException Locked="false" Priority="39" Name="Table Grid"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Theme"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Placeholder Text"/>
  <w:LsdException Locked="false" Priority="1" QFormat="true" Name="No Spacing"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 1"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 1"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Revision"/>
  <w:LsdException Locked="false" Priority="34" QFormat="true"
   Name="List Paragraph"/>
  <w:LsdException Locked="false" Priority="29" QFormat="true" Name="Quote"/>
  <w:LsdException Locked="false" Priority="30" QFormat="true"
   Name="Intense Quote"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 1"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 1"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 2"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 2"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 2"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 3"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 3"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 3"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 4"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 4"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 4"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 5"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 5"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 5"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 6"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 6"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 6"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="19" QFormat="true"
   Name="Subtle Emphasis"/>
  <w:LsdException Locked="false" Priority="21" QFormat="true"
   Name="Intense Emphasis"/>
  <w:LsdException Locked="false" Priority="31" QFormat="true"
   Name="Subtle Reference"/>
  <w:LsdException Locked="false" Priority="32" QFormat="true"
   Name="Intense Reference"/>
  <w:LsdException Locked="false" Priority="33" QFormat="true" Name="Book Title"/>
  <w:LsdException Locked="false" Priority="37" SemiHidden="true"
   UnhideWhenUsed="true" Name="Bibliography"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="TOC Heading"/>
  <w:LsdException Locked="false" Priority="41" Name="Plain Table 1"/>
  <w:LsdException Locked="false" Priority="42" Name="Plain Table 2"/>
  <w:LsdException Locked="false" Priority="43" Name="Plain Table 3"/>
  <w:LsdException Locked="false" Priority="44" Name="Plain Table 4"/>
  <w:LsdException Locked="false" Priority="45" Name="Plain Table 5"/>
  <w:LsdException Locked="false" Priority="40" Name="Grid Table Light"/>
  <w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="46" Name="List Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hashtag"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Unresolved Mention"/>
 </w:LatentStyles>
</xml><![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:3 0 0 0 1 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-536858881 -1073732485 9 0 511 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;}
a:link, span.MsoHyperlink
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:#2072BC;
	font-weight:bold;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:#954F72;
	mso-themecolor:followedhyperlink;
	text-decoration:underline;
	text-underline:single;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-style-unhide:no;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:"Times New Roman";
	mso-fareast-theme-font:minor-fareast;}
span.normaltextrun
	{mso-style-name:normaltextrun;
	mso-style-unhide:no;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	font-size:10.0pt;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:"Calibri",sans-serif;
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=EN-US link="#2072BC" vlink="#954F72" style='tab-interval:.5in'>

<div class=WordSection1>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0 align=left
 width=699 style='width:524.0pt;mso-cellspacing:0in;mso-yfti-tbllook:1184;
 mso-table-lspace:9.0pt;margin-left:6.75pt;mso-table-rspace:9.0pt;margin-right:
 6.75pt;mso-table-bspace:8.0pt;margin-bottom:5.75pt;mso-table-anchor-vertical:
 paragraph;mso-table-anchor-horizontal:margin;mso-table-left:left;mso-table-top:
 -59.95pt;mso-padding-alt:0in 0in 0in 0in'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes'>
  <td style='padding:3.75pt 3.75pt 3.75pt 3.75pt'>
  <table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 align=left
   width=668 style='width:501.0pt;mso-cellspacing:0in;border:solid #E9E9EF 3.0pt;
   mso-yfti-tbllook:1184;margin-left:-2.25pt;margin-right:-2.25pt;mso-table-bspace:
   8.0pt;margin-bottom:5.75pt;mso-table-anchor-vertical:paragraph;mso-table-anchor-horizontal:
   margin;mso-table-left:left;mso-padding-alt:0in 0in 0in 0in'>
   <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
    <td style='border:none;padding:0in 0in 0in 0in'>
    <table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
     align=left width=660 style='width:495.0pt;mso-cellspacing:0in;mso-yfti-tbllook:
     1184;margin-left:-2.25pt;margin-right:-2.25pt;mso-table-bspace:8.0pt;
     margin-bottom:5.75pt;mso-table-anchor-vertical:paragraph;mso-table-anchor-horizontal:
     margin;mso-table-left:left;mso-padding-alt:0in 0in 0in 0in'>
     <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes;
      height:41.25pt'>
      <td style='background:white;padding:0in 0in 0in 0in;height:41.25pt'></td>
      <td style='background:white;padding:10.5pt 0in 0in 0in;height:41.25pt'>
      <table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
       align=left width=659 style='width:494.45pt;mso-cellspacing:0in;
       mso-yfti-tbllook:1184;margin-left:-2.25pt;margin-right:-2.25pt;
       mso-table-bspace:8.0pt;margin-bottom:5.75pt;mso-table-anchor-vertical:
       paragraph;mso-table-anchor-horizontal:margin;mso-table-left:left;
       mso-padding-alt:0in 0in 0in 0in'>
       <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:21.65pt'>
        <td style='padding:0in 7.5pt 11.25pt 0in;height:21.65pt'>
        <p class=MsoNormal style='line-height:106%;mso-element:frame;
        mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
        paragraph;mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;
        mso-height-rule:exactly'><span style='font-size:10.0pt;line-height:
        106%;font-family:"Arial",sans-serif;color:#2F5496;mso-themecolor:accent1;
        mso-themeshade:191;mso-no-proof:yes'><!--[if gte vml 1]><v:shapetype
         id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
         path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
         <v:stroke joinstyle="miter"/>
         <v:formulas>
          <v:f eqn="if lineDrawn pixelLineWidth 0"/>
          <v:f eqn="sum @0 1 0"/>
          <v:f eqn="sum 0 0 @1"/>
          <v:f eqn="prod @2 1 2"/>
          <v:f eqn="prod @3 21600 pixelWidth"/>
          <v:f eqn="prod @3 21600 pixelHeight"/>
          <v:f eqn="sum @0 0 1"/>
          <v:f eqn="prod @6 1 2"/>
          <v:f eqn="prod @7 21600 pixelWidth"/>
          <v:f eqn="sum @8 21600 0"/>
          <v:f eqn="prod @7 21600 pixelHeight"/>
          <v:f eqn="sum @10 21600 0"/>
         </v:formulas>
         <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
         <o:lock v:ext="edit" aspectratio="t"/>
        </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_i1026"
         type="#_x0000_t75" style='width:198pt;height:31.2pt;visibility:visible;
         mso-wrap-style:square'>
         <v:imagedata src="https://www.unisys.com/Style%20Library/unisys/images/unisys_logo.png"
          o:title=""/>
        </v:shape><![endif]--><![if !vml]><img width=264 height=42
        src="https://www.unisys.com/Style%20Library/unisys/images/unisys_logo.png" v:shapes="Picture_x0020_1"><![endif]></span><span
        style='font-size:10.0pt;line-height:106%;font-family:"Arial",sans-serif'><o:p></o:p></span></p>
        </td>
       </tr>
       <tr style='mso-yfti-irow:1;mso-yfti-lastrow:yes;height:21.65pt'>
        <td style='padding:0in 7.5pt 0in 0in;height:21.65pt'>
        <p class=MsoNormal align=right style='text-align:right;mso-line-height-alt:
        13.5pt;mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:
        around;mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:
        margin;mso-element-top:-59.95pt;mso-height-rule:exactly'><span
        style='font-size:17.5pt;font-family:"Arial",sans-serif;color:#1F497D'>Technology
        Infrastructure Services</span><span style='font-size:17.5pt;font-family:
        "Arial",sans-serif;color:#002E5F'> <o:p></o:p></span></p>
        </td>
       </tr>
      </table>
      </td>
     </tr>
    </table>
    </td>
   </tr>
   <tr style='mso-yfti-irow:1'>
    <td style='border-top:solid #E9E9EF 1.0pt;border-left:none;border-bottom:
    solid #E9E9EF 1.0pt;border-right:none;background:white;padding:3.75pt 11.25pt 4.5pt 16.5pt'>
    <p class=MsoNormal style='line-height:13.5pt;mso-element:frame;mso-element-frame-hspace:
    9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
    mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
    exactly'><span style='font-size:10.5pt;font-family:"Arial",sans-serif;
    color:#002E5F'>To Associates </span><span style='font-size:10.5pt;
    font-family:"Arial",sans-serif;color:#1F497D'>who require action on
    Microsoft SCCM Client</span><span style='font-size:10.5pt;font-family:"Arial",sans-serif;
    color:#002E5F'><o:p></o:p></span></p>
    </td>
   </tr>
   <tr style='mso-yfti-irow:2'>
    <td style='border:none;background:white;padding:19.5pt 18.75pt 3.75pt 18.75pt'>
    <table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
     align=left width=609 style='width:456.75pt;mso-cellspacing:0in;mso-yfti-tbllook:
     1184;margin-left:-2.25pt;margin-right:-2.25pt;mso-table-bspace:8.0pt;
     margin-bottom:5.75pt;mso-table-anchor-vertical:paragraph;mso-table-anchor-horizontal:
     margin;mso-table-left:left;mso-padding-alt:0in 0in 0in 0in'>
     <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:33.3pt'>
      <td style='padding:0in 0in 3.75pt 0in;height:33.3pt'>
      <p class=MsoNormal style='mso-line-height-alt:13.5pt;mso-element:frame;
      mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
      paragraph;mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;
      mso-height-rule:exactly'><b><span style='font-size:15.0pt;font-family:
      "Arial",sans-serif;color:#1F497D'>February 2020 : Microsoft SCCM client -
      Immediate Action Required<o:p></o:p></span></b></p>
      </td>
     </tr>
     <tr style='mso-yfti-irow:1'>
      <td width=609 valign=top style='width:456.75pt;padding:0in 5.4pt 0in 5.4pt'>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'>Dear
      <b style='mso-bidi-font-weight:normal'>$User1</b>,<o:p></o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif;
      color:#1F497D'><o:p>&nbsp;</o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'>You
      are listed as the registered owner of the following VM(s): <b
      style='mso-bidi-font-weight:normal'>$Comp</b> <o:p></o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'>These
      systems are currently not reporting system information as required by
      corporate policy.&nbsp; <o:p></o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'><o:p>&nbsp;</o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><b><span lang=EN style='font-size:11.0pt;line-height:106%;
      font-family:"Arial",sans-serif;color:red;mso-ansi-language:EN'>All Unisys
      owned systems that connect to the Unisys network are required to have the
      SCCM Client installed</span></b><b><span lang=EN style='font-size:11.0pt;
      line-height:106%;font-family:"Arial",sans-serif;color:#990000;mso-ansi-language:
      EN'> </span></b><b><span lang=EN style='font-size:11.0pt;line-height:
      106%;font-family:"Arial",sans-serif;color:red;mso-ansi-language:EN'>and
      reporting.</span></b><b><span lang=EN style='font-size:11.0pt;line-height:
      106%;font-family:"Arial",sans-serif;color:#990000;mso-ansi-language:EN'><o:p></o:p></span></b></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'><o:p>&nbsp;</o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'>Your
      system either is missing or has a non-functional Microsoft SCCM client. </span><span
      lang=EN style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif;
      mso-ansi-language:EN'>SCCM is a mechanism for gathering hardware and software
      inventory, and for installing and tracking software and updates on
      endpoint computers.<o:p></o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'><o:p>&nbsp;</o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'>The
      <a href="https://riskmanagement.unisys.com/selfhelp/SCCM/index.php"><b><span
      lang=EN style='mso-ansi-language:EN'>IT Computer Compliance, Security
      &amp; Privacy</span></b></a></span><span lang=EN style='font-size:11.0pt;
      line-height:106%;font-family:"Arial",sans-serif;mso-ansi-language:EN'>
      Corporate Compliance web link has information and instructions.</span><span
      style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'><o:p></o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'><o:p>&nbsp;</o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'>Please
      go to the following Unisys web link to download and install the SCCM
      repair tool listed below <b>at the earliest</b> to try to repair your
      system.<o:p></o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'><o:p>&nbsp;</o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'><a
      href="https://unisyscorp.sharepoint.com/sites/UIT/gsd/SitePages/utilities.aspx"><b><span
      style='color:windowtext'>Unisys</span> SCCM Tool Link</b></a><o:p></o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'>“<a
      href="https://unisyscorp.sharepoint.com/sites/UIT/gsd/SitePages/utilities.aspx"><b>https://unisyscorp.sharepoint.com/sites/UIT/gsd/SitePages/utilities.aspx</b></a>”<o:p></o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'><o:p>&nbsp;</o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'>Download
      and run the following Repair Tool<o:p></o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif;
      mso-no-proof:yes'><!--[if gte vml 1]><v:shape id="Picture_x0020_2"
       o:spid="_x0000_i1025" type="#_x0000_t75" style='width:407.4pt;height:139.8pt;
       visibility:visible;mso-wrap-style:square'>
       <v:imagedata src="http://inblr-vm-1987.eu.uis.unisys.com/images/sccm.jpg"
        o:title=""/>
      </v:shape><![endif]--><![if !vml]><img border=0 width=543 height=186
      src="http://inblr-vm-1987.eu.uis.unisys.com/images/sccm.jpg" v:shapes="Picture_x0020_2"><![endif]></span><span
      style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'><o:p></o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'><o:p>&nbsp;</o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span class=normaltextrun><span style='font-size:11.0pt;
      line-height:106%;font-family:"Arial",sans-serif;color:black;background:
      white'>If you encounter errors/failures during repair process, please
      submit a ticket using the&nbsp;</span></span><span style='font-size:11.0pt;
      line-height:106%;font-family:"Arial",sans-serif'><a
      href="https://unisyscorp.sharepoint.com/sites/tis/Public%20Documents/Forms/AllItems.aspx?viewid=ac975255%2D8972%2D4a90%2Daaf7%2D268cf2e76761&amp;id=%2Fsites%2Ftis%2FPublic%20Documents%2FService%20Desk%20Support"
      target="_blank"><span class=normaltextrun><b><span style='color:#0563C1;
      background:white'>TIS Support Process</span></b></span></a><span
      class=normaltextrun><span style='color:black;background:white'>&nbsp;and
      indicate the system name that you would like evaluated and repaired.</span></span><o:p></o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'><o:p>&nbsp;</o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span class=GramE><span style='font-size:11.0pt;line-height:
      106%;font-family:"Arial",sans-serif'>Thanks</span></span><span
      style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'>
      and Regards,<o:p></o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'>Technology
      Infrastructure Services &nbsp; <o:p></o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif'><o:p>&nbsp;</o:p></span></p>
      <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
      9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
      mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
      exactly'><span style='font-size:11.0pt;line-height:106%;font-family:"Arial",sans-serif;
      color:#1F497D'><o:p>&nbsp;</o:p></span></p>
      </td>
     </tr>
     <tr style='mso-yfti-irow:2;mso-yfti-lastrow:yes'>
      <td style='padding:0in 0in 0in 0in'>
      <table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
       align=left width=609 style='width:456.75pt;mso-cellspacing:0in;
       mso-yfti-tbllook:1184;margin-left:-2.25pt;margin-right:-2.25pt;
       mso-table-bspace:8.0pt;margin-bottom:5.75pt;mso-table-anchor-vertical:
       paragraph;mso-table-anchor-horizontal:margin;mso-table-left:left;
       mso-padding-alt:0in 0in 0in 0in'>
       <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes'>
        <td width=438 valign=top style='width:328.5pt;padding:0in .75in 0in 0in'></td>
       </tr>
      </table>
      </td>
     </tr>
    </table>
    </td>
   </tr>
   <tr style='mso-yfti-irow:3;mso-yfti-lastrow:yes'>
    <td style='border:none;background:white;padding:14.25pt 0in 0in 0in'>
    <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
    9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
    mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
    exactly'><o:p>&nbsp;</o:p></p>
    </td>
   </tr>
  </table>
  <p class=MsoNormal style='line-height:13.5pt;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
  mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
  exactly'><span style='font-size:10.0pt;font-family:"Arial",sans-serif'><o:p>&nbsp;</o:p></span></p>
  <table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0 align=left
   width=660 style='width:495.0pt;mso-cellspacing:0in;mso-yfti-tbllook:1184;
   margin-left:-2.25pt;margin-right:-2.25pt;mso-table-bspace:8.0pt;margin-bottom:
   5.75pt;mso-table-anchor-vertical:paragraph;mso-table-anchor-horizontal:margin;
   mso-table-left:left;mso-padding-alt:0in 0in 0in 0in'>
   <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes'>
    <td width=660 valign=top style='width:495.0pt;padding:0in 0in 0in 0in'></td>
   </tr>
  </table>
  <p class=MsoNormal style='line-height:106%;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;
  mso-element-anchor-horizontal:margin;mso-element-top:-59.95pt;mso-height-rule:
  exactly'><o:p></o:p></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><span style='font-size:11.0pt;font-family:"Calibri",sans-serif;
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>


"@

#echo $comp

         Send-MailMessage -To "$email"  -From "Donot-Reply-TIS_India@unisys.com" -Bcc "rashmi.prakash@in.unisys.com","karthik.t2@in.unisys.com" -Subject "February 2020 : Microsoft SCCM client - Immediate Action Required" -Body $body -BodyAsHtml   -SmtpServer NA-MAILRELAY-T3.na.uis.unisys.com
         #Send-MailMessage -To "karthik.t2@in.unisys.com"  -From "Thyagaraju, Karthik <karthik.t2@in.unisys.com>" -cc "karthik.t2@in.unisys.com" -Subject "February 2020 : Microsoft SCCM client - Immediate Action Required" -Body $body -BodyAsHtml   -SmtpServer NA-MAILRELAY-T3.na.uis.unisys.com
           echo "Sent mail to " $email " for following machines"    $comp           
           $comp = $null
           $comp1 = $null
        }
    
    }


