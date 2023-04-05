#Script to do the
Add-Type -AssemblyName System.Windows.Forms

function startRobo () {
   $roboSrc = $src_tbox.Text
   $roboDst = $dst_tbox.Text
   $copy_options = "/COPY:"
   if ($data_chk.Checked) {
      $copy_options +="D"
   }
   if ($attrib_chk.Checked) {
      $copy_options +="A"
   }
   if ($ts_chk.Checked) {
      $copy_options +="T"
   }
   if ($sec_chk.Checked) {
      $copy_options +="S"
   }
   if ($own_chk.Checked) {
      $copy_options +="O"
   }
   if ($audit_chk.Checked) {
      $copy_options +="U"
   }
   $excluded_dirs = "/XD `$RECYCLE.BIN `"Temporary Internet Files`" Temp OLDHD Microsoft.Net `$hf_mig$ ie8updates ie7updates ServicePackFiles assembly SoftwareDistribution Windows winsxs"
   $excluded_files = "/XF MRT.exe pagefile.sys hiberfil.sys *.ost"
   $log_file="roboResult.txt"
   $timestamp= Get-Date -Format MMddyyyy-hhmmss
   $log = "/LOG+:`"$roboDst\$timestamp$log_file`""
   
   $argsList = $roboSrc, $roboDst, $copy_options , "/MT:64", "/E", "/NP", "/XJ", $excluded_dirs, $excluded_files, "/R:2", "/W:1" , $log
   if(Test-Path $roboDst)
   {  
      Start-Process -Wait robocopy -ArgumentList $argsList
      start-Process notepad $roboDst\$timestamp$log_file
   } else {
      mkdir $roboDst
      Start-Process -Wait robocopy -ArgumentList $argsList
      start-Process notepad $roboDst\$timestamp$log_file
   }
   $robo_form.Close()

   #Start-Process -Wait robocopy -ArgumentList $roboSrc $roboDst $copy_options /MT:64 /E /NP /XJ /R:2 /W:1 $log

}


$robo_form = New-Object System.Windows.Forms.Form
$robo_form.Text = "Robocopy Script"
$robo_form.AutoSize = $true
$robo_form.Height = 300
$robo_form.Width = 306

$src_label = New-Object System.Windows.Forms.Label
$src_label.Text = "Source (no trailing slash):"
$src_label.AutoSize = $true
$src_label.Location = New-Object System.Drawing.Point(3,15)
$robo_form.Controls.Add($src_label)

$src_tbox = New-Object System.Windows.Forms.TextBox
$src_tbox.Width = 300
$src_tbox.Height = 20
$src_tbox.Location = New-Object System.Drawing.Point(3,35)
$robo_form.Controls.Add($src_tbox)

$dst_label = New-Object System.Windows.Forms.Label
$dst_label.Text = "Destination (no trailing slash):"
$dst_label.AutoSize = $true
$dst_label.Location = New-Object System.Drawing.Point(3,65)
$robo_form.Controls.Add($dst_label)

$dst_tbox = New-Object System.Windows.Forms.TextBox
$dst_tbox.Width = 300
$dst_tbox.height = 20
$dst_tbox.Location = New-Object System.Drawing.Point(3,85)
$robo_form.Controls.Add($dst_tbox)

$chk_label = New-Object System.Windows.Forms.Label
$chk_label.Text = "Things to be copied:"
$chk_label.AutoSize = $true
$chk_label.Location = New-Object System.Drawing.Point(3,115)
$robo_form.Controls.Add($chk_label)

$data_label = New-Object System.Windows.Forms.Label
$data_label.Text = "Data:"
$data_label.AutoSize = $true
$data_label.Location = New-Object System.Drawing.Point(3,140)
$robo_form.Controls.Add($data_label)

$data_chk = New-Object System.Windows.Forms.CheckBox
$data_chk.Checked = $true
$data_chk.Location = New-Object System.Drawing.Point(40,140)
$data_chk.AutoSize = $true
$robo_form.Controls.Add($data_chk)

$attrib_label = New-Object System.Windows.Forms.Label
$attrib_label.Text = "Attributes:"
$attrib_label.AutoSize = $true
$attrib_label.Location = New-Object System.Drawing.Point(105,140)
$robo_form.Controls.Add($attrib_label)

$attrib_chk = New-Object System.Windows.Forms.CheckBox
$attrib_chk.Checked = $true
$attrib_chk.Location = New-Object System.Drawing.Point(163,140)
$attrib_chk.AutoSize = $true
$robo_form.Controls.Add($attrib_chk)

$ts_label = New-Object System.Windows.Forms.Label
$ts_label.Text = "Time stamps:"
$ts_label.AutoSize = $true
$ts_label.Location = New-Object System.Drawing.Point(212,140)
$robo_form.Controls.Add($ts_label)

$ts_chk = New-Object System.Windows.Forms.CheckBox
$ts_chk.Checked = $true
$ts_chk.Location = New-Object System.Drawing.Point(285,140)
$ts_chk.AutoSize = $true
$robo_form.Controls.Add($ts_chk)

$sec_label = New-Object System.Windows.Forms.Label
$sec_label.Text = "Permissions:"
$sec_label.AutoSize = $true
$sec_label.Location = New-Object System.Drawing.Point(3,165)
$robo_form.Controls.Add($sec_label)

$sec_chk = New-Object System.Windows.Forms.CheckBox
$sec_chk.Checked = $false
$sec_chk.Location = New-Object System.Drawing.Point(73,165)
$sec_chk.AutoSize = $true
$robo_form.Controls.Add($sec_chk)

$own_label = New-Object System.Windows.Forms.Label
$own_label.Text = "Owner info:"
$own_label.AutoSize = $true
$own_label.Location = New-Object System.Drawing.Point(103,165)
$robo_form.Controls.Add($own_label)

$own_chk = New-Object System.Windows.Forms.CheckBox
$own_chk.Checked = $false
$own_chk.Location = New-Object System.Drawing.Point(170,165)
$own_chk.AutoSize = $true
$robo_form.Controls.Add($own_chk)

$audit_label = New-Object System.Windows.Forms.Label
$audit_label.Text = "Audit info:"
$audit_label.AutoSize = $true
$audit_label.Location = New-Object System.Drawing.Point(210,165)
$robo_form.Controls.Add($audit_label)

$audit_chk = New-Object System.Windows.Forms.CheckBox
$audit_chk.Checked = $false
$audit_chk.Location = New-Object System.Drawing.Point(285,165)
$audit_chk.AutoSize = $true
$robo_form.Controls.Add($audit_chk)

$start_button = New-Object System.Windows.Forms.Button
$start_button.Text = "Start Robocopy"
$start_button.Location = New-Object System.Drawing.Point(110,225)
$start_button.Add_Click({startRobo})
$start_button.AutoSize = $true
$robo_form.Controls.Add($start_button)

$robo_form.ShowDialog()
