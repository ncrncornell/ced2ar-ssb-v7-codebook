# Converting the raw metadata into editable DDI
We start with a zero-obs SAS dataset.

## Step 1: Convert SAS to Stata
CED2AR does not handle SAS datasets, so we convert it (using SAS) to Stata
```
sas convert.sas
```

## Step 2: Adjust Stata file
While zero-obs files work well with SAS, Stata does not like them. We simply set observation count to 10 (arbitrary number).
```
stata do convert.do
```

## Step 3: Convert to XML/DDI
We used the command line conversion tool at https://github.com/ncrncornell/ced2arddigenerator/releases to convert the Stata dataset to DDI. Note that in this case, the conversion is quite trivial, since there are no statistics to be generated.
```
java -jar ced2arddigenerator-jar-with-dependencies.jar -f ssb_v7_0_synthetic_new_vars.dta  -s false
```

## Prepare the DDI for merge
We used a partial datafile (only new variables) to splice it onto the old DDI file. We need to adjust the variable IDs. One solution would be to generate random IDs. Here, we simply prepend them with "v7".
```
sed -i -s 's/ID="V/ID="v7V/' ssb_v7_0_synthetic_new_vars.dta.xml 
```

## Splicing the files together
The entire contents of the `<dataDscr>` field (but not the tag itself) need to be added to the previous version (v6.0.2). While that might be relatively straightforward in Python, we simply did it manually here.

# Final file editing
Once the base file has been created, we upload to CED2AR for further editing.

