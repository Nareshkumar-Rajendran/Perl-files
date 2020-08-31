use Spreadsheet::ParseExcel;


my $excel_name = 'Yours Excel Name';
xls2csv($excel_name);
$excel_name=~s/xls/csv/igs;
sub xls2csv
{
	my $excelname = shift;
	print "$excelname\n";
	my $parser   = Spreadsheet::ParseExcel->new();
	my $workbook = $parser->parse($excelname);
	$excelname=~s/xls/csv/igs;
	open(FH,">>$excelname");
	foreach my $worksheet ( $workbook->worksheets() )
	{
		my ($row_min,$row_max) = $worksheet->row_range();
		my ($col_min,$col_max) = $worksheet->col_range();
		print ($row_min,$row_max,$col_min,$col_max);
		foreach my $row($row_min..$row_max)
		{
			foreach my $col($col_min..$col_max)
			{
				my $cell = $worksheet->get_cell( $row, $col );
				unless($cell)
				{
					print FH ",";
					next;
				}
				my $value=$cell->value();
				if($col==0)
				{
					print FH "\"".$value."\";";
				}
				else
				{
					print FH $value.";";
				}
			}
			print FH "\n";
		}
	}
	close FH;
	return 1;
}