Tutorial 5: Cleaning and analyzing questionnaires/surveys (reliability)
================
Hause Lin

-   [Loading frequently-used packages with `library()`](#loading-frequently-used-packages-with-library)
-   [Read data (Qualtrics survey data)](#read-data-qualtrics-survey-data)
-   [Select questionnaire items for relability analysis](#select-questionnaire-items-for-relability-analysis)
-   [Use `cleanQuestionnaire()` function instead](#use-cleanquestionnaire-function-instead)
-   [Another `cleanQuestionnaire()` example](#another-cleanquestionnaire-example)
-   [Joining and saving wide data from multiple scales](#joining-and-saving-wide-data-from-multiple-scales)
-   [Save joined data as .rds object (one object at a time)](#save-joined-data-as-.rds-object-one-object-at-a-time)
-   [Save your entire workspace and all objects in environment as .RData (all objects)](#save-your-entire-workspace-and-all-objects-in-environment-as-.rdata-all-objects)

Loading frequently-used packages with `library()`
-------------------------------------------------

I always load my frequently-used packages at the top of each script.

``` r
library(tidyverse); library(data.table); library(broom); library(dtplyr); library(lme4); library(lmerTest); library(ggbeeswarm); library(cowplot)
```

Read data (Qualtrics survey data)
---------------------------------

Here's a raw dataset collected using Qualtrics

``` r
df1 <- tbl_dt(fread("./Data/qualtricsSurvey.csv"))
df1
```

    ## Source: local data table [277 x 41]
    ## 
    ## # A tibble: 277 x 41
    ##    V1     V2     V3    V4    V5    V6    V7    V8    V9    V10   condition
    ##    <chr>  <chr>  <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>    
    ##  1 Respo… Respo… Name  Exte… Emai… IPAd… Stat… Star… EndD… Fini… condition
    ##  2 R_1eC… Defau… Anon… ""    ""    139.… 0     2015… 2015… 1     control  
    ##  3 R_DNW… Defau… Anon… ""    ""    82.6… 0     2015… 2015… 1     control  
    ##  4 R_1Oj… Defau… Anon… ""    ""    82.2… 0     2015… 2015… 1     interven…
    ##  5 R_egk… Defau… Anon… ""    ""    82.6… 0     2015… 2015… 1     interven…
    ##  6 R_1Qo… Defau… Anon… ""    ""    81.1… 0     2015… 2015… 1     control  
    ##  7 R_6Pu… Defau… Anon… ""    ""    139.… 0     2015… 2015… 1     control  
    ##  8 R_1dd… Defau… Anon… ""    ""    86.1… 0     2015… 2015… 1     interven…
    ##  9 R_ZBR… Defau… Anon… ""    ""    86.1… 0     2015… 2015… 1     interven…
    ## 10 R_24i… Defau… Anon… ""    ""    31.5… 0     2015… 2015… 1     interven…
    ## # ... with 267 more rows, and 30 more variables: InterInfo <chr>,
    ## #   consentI <chr>, ContrInfo <chr>, consentC <chr>, Q9 <chr>, id <chr>,
    ## #   Q10 <chr>, MalleableC_1 <chr>, MalleableC_2 <chr>, MalleableC_3 <chr>,
    ## #   MalleableC_4 <chr>, Expect_1 <chr>, Expect_2 <chr>, Expect_3 <chr>,
    ## #   ImplicitB_1 <chr>, ImplicitB_2 <chr>, ImplicitB_3 <chr>,
    ## #   ImplicitB_4 <chr>, ImplicitB_5 <chr>, ImplicitB_6 <chr>,
    ## #   Workload_1 <chr>, Workload_2 <chr>, Workload_3 <chr>,
    ## #   Workload_4 <chr>, Workload_5 <chr>, Workload_6 <chr>, Q10 <chr>,
    ## #   LocationLatitude <chr>, LocationLongitude <chr>,
    ## #   LocationAccuracy <chr>

``` r
glimpse(df1)
```

    ## Observations: 277
    ## Variables: 41
    ## $ V1                <chr> "ResponseID", "R_1eCQEdLmpgjpFwK", "R_DNWzxi...
    ## $ V2                <chr> "ResponseSet", "Default Response Set", "Defa...
    ## $ V3                <chr> "Name", "Anonymous", "Anonymous", "Anonymous...
    ## $ V4                <chr> "ExternalDataReference", "", "", "", "", "",...
    ## $ V5                <chr> "EmailAddress", "", "", "", "", "", "", "", ...
    ## $ V6                <chr> "IPAddress", "139.184.223.149", "82.6.25.163...
    ## $ V7                <chr> "Status", "0", "0", "0", "0", "0", "0", "0",...
    ## $ V8                <chr> "StartDate", "2015-03-12 19:37", "2015-03-12...
    ## $ V9                <chr> "EndDate", "2015-03-12 19:44", "2015-03-12 2...
    ## $ V10               <chr> "Finished", "1", "1", "1", "1", "1", "1", "1...
    ## $ condition         <chr> "condition", "control", "control", "interven...
    ## $ InterInfo         <chr> "Thanks for your interest in the study! Befo...
    ## $ consentI          <chr> "Consent", "", "", "1", "1", "", "", "1", "1...
    ## $ ContrInfo         <chr> "Thanks for your interest in the study! Befo...
    ## $ consentC          <chr> "Consent", "1", "1", "", "", "1", "1", "", "...
    ## $ Q9                <chr> "Email Address /  / Thank you for agreeing t...
    ## $ id                <chr> "Enter your email below (we will be emailing...
    ## $ Q10               <chr> "Thanks for providing your email address. If...
    ## $ MalleableC_1      <chr> "Answer the questions below using the scale ...
    ## $ MalleableC_2      <chr> "Answer the questions below using the scale ...
    ## $ MalleableC_3      <chr> "Answer the questions below using the scale ...
    ## $ MalleableC_4      <chr> "Answer the questions below using the scale ...
    ## $ Expect_1          <chr> "Answer the questions below using the scale ...
    ## $ Expect_2          <chr> "Answer the questions below using the scale ...
    ## $ Expect_3          <chr> "Answer the questions below using the scale ...
    ## $ ImplicitB_1       <chr> "Answer the questions below using the scale ...
    ## $ ImplicitB_2       <chr> "Answer the questions below using the scale ...
    ## $ ImplicitB_3       <chr> "Answer the questions below using the scale ...
    ## $ ImplicitB_4       <chr> "Answer the questions below using the scale ...
    ## $ ImplicitB_5       <chr> "Answer the questions below using the scale ...
    ## $ ImplicitB_6       <chr> "Answer the questions below using the scale ...
    ## $ Workload_1        <chr> " Using a scale of 1 to 21, answer the quest...
    ## $ Workload_2        <chr> " Using a scale of 1 to 21, answer the quest...
    ## $ Workload_3        <chr> " Using a scale of 1 to 21, answer the quest...
    ## $ Workload_4        <chr> " Using a scale of 1 to 21, answer the quest...
    ## $ Workload_5        <chr> " Using a scale of 1 to 21, answer the quest...
    ## $ Workload_6        <chr> " Using a scale of 1 to 21, answer the quest...
    ## $ Q10               <chr> "Thanks for becoming a participant in our st...
    ## $ LocationLatitude  <chr> "LocationLatitude", "50.82460022", "50.82240...
    ## $ LocationLongitude <chr> "LocationLongitude", "-0.155502319", "-0.110...
    ## $ LocationAccuracy  <chr> "LocationAccuracy", "-1", "-1", "-1", "-1", ...

With Qualtrics datasets, the first row (or even first few rows) of the dataset might contain irrelevant variables and information. If they contain extra rows, do the following to get rid of rows (commented out for now). But play with your dataset to see which rows you should remove.

In this example, row 1 contains extra data (the actual questions themselves), so we're removing it.

``` r
df1 <- tbl_dt(fread("./Data/qualtricsSurvey.csv"))[-1] # delete row 1
# df1 <- tbl_dt(fread("./Data/qualtricsSurvey.csv"))[-c(1:5)] # delete rows 1:5 (example)
df1
```

    ## Source: local data table [276 x 41]
    ## 
    ## # A tibble: 276 x 41
    ##    V1     V2     V3    V4    V5    V6    V7    V8    V9    V10   condition
    ##    <chr>  <chr>  <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>    
    ##  1 R_1eC… Defau… Anon… ""    ""    139.… 0     2015… 2015… 1     control  
    ##  2 R_DNW… Defau… Anon… ""    ""    82.6… 0     2015… 2015… 1     control  
    ##  3 R_1Oj… Defau… Anon… ""    ""    82.2… 0     2015… 2015… 1     interven…
    ##  4 R_egk… Defau… Anon… ""    ""    82.6… 0     2015… 2015… 1     interven…
    ##  5 R_1Qo… Defau… Anon… ""    ""    81.1… 0     2015… 2015… 1     control  
    ##  6 R_6Pu… Defau… Anon… ""    ""    139.… 0     2015… 2015… 1     control  
    ##  7 R_1dd… Defau… Anon… ""    ""    86.1… 0     2015… 2015… 1     interven…
    ##  8 R_ZBR… Defau… Anon… ""    ""    86.1… 0     2015… 2015… 1     interven…
    ##  9 R_24i… Defau… Anon… ""    ""    31.5… 0     2015… 2015… 1     interven…
    ## 10 R_3KB… Defau… Anon… ""    ""    139.… 0     2015… 2015… 1     interven…
    ## # ... with 266 more rows, and 30 more variables: InterInfo <chr>,
    ## #   consentI <chr>, ContrInfo <chr>, consentC <chr>, Q9 <chr>, id <chr>,
    ## #   Q10 <chr>, MalleableC_1 <chr>, MalleableC_2 <chr>, MalleableC_3 <chr>,
    ## #   MalleableC_4 <chr>, Expect_1 <chr>, Expect_2 <chr>, Expect_3 <chr>,
    ## #   ImplicitB_1 <chr>, ImplicitB_2 <chr>, ImplicitB_3 <chr>,
    ## #   ImplicitB_4 <chr>, ImplicitB_5 <chr>, ImplicitB_6 <chr>,
    ## #   Workload_1 <chr>, Workload_2 <chr>, Workload_3 <chr>,
    ## #   Workload_4 <chr>, Workload_5 <chr>, Workload_6 <chr>, Q10 <chr>,
    ## #   LocationLatitude <chr>, LocationLongitude <chr>,
    ## #   LocationAccuracy <chr>

``` r
glimpse(df1)
```

    ## Observations: 276
    ## Variables: 41
    ## $ V1                <chr> "R_1eCQEdLmpgjpFwK", "R_DNWzxibw4F3jzKp", "R...
    ## $ V2                <chr> "Default Response Set", "Default Response Se...
    ## $ V3                <chr> "Anonymous", "Anonymous", "Anonymous", "Anon...
    ## $ V4                <chr> "", "", "", "", "", "", "", "", "", "", "", ...
    ## $ V5                <chr> "", "", "", "", "", "", "", "", "", "", "", ...
    ## $ V6                <chr> "139.184.223.149", "82.6.25.163", "82.2.185....
    ## $ V7                <chr> "0", "0", "0", "0", "0", "0", "0", "0", "0",...
    ## $ V8                <chr> "2015-03-12 19:37", "2015-03-12 21:58", "201...
    ## $ V9                <chr> "2015-03-12 19:44", "2015-03-12 22:07", "201...
    ## $ V10               <chr> "1", "1", "1", "1", "1", "1", "1", "1", "1",...
    ## $ condition         <chr> "control", "control", "intervention", "inter...
    ## $ InterInfo         <chr> "", "", "1", "1", "", "", "1", "1", "1", "1"...
    ## $ consentI          <chr> "", "", "1", "1", "", "", "1", "1", "1", "1"...
    ## $ ContrInfo         <chr> "1", "1", "", "", "1", "1", "", "", "", "", ...
    ## $ consentC          <chr> "1", "1", "", "", "1", "1", "", "", "", "", ...
    ## $ Q9                <chr> "1", "1", "1", "1", "1", "1", "1", "1", "1",...
    ## $ id                <chr> "1", "2", "3", "4", "5", "6", "7", "8", "9",...
    ## $ Q10               <chr> "1", "1", "1", "1", "1", "1", "1", "1", "1",...
    ## $ MalleableC_1      <chr> "2", "6", "5", "5", "2", "5", "6", "5", "6",...
    ## $ MalleableC_2      <chr> "4", "6", "5", "5", "2", "6", "6", "5", "6",...
    ## $ MalleableC_3      <chr> "4", "1", "2", "2", "3", "2", "1", "1", "2",...
    ## $ MalleableC_4      <chr> "1", "1", "2", "2", "5", "2", "1", "2", "2",...
    ## $ Expect_1          <chr> "3", "6", "4", "5", "2", "6", "4", "4", "4",...
    ## $ Expect_2          <chr> "5", "6", "4", "5", "3", "6", "4", "6", "6",...
    ## $ Expect_3          <chr> "4", "2", "3", "2", "5", "2", "3", "3", "1",...
    ## $ ImplicitB_1       <chr> "1", "6", "6", "4", "3", "6", "4", "5", "5",...
    ## $ ImplicitB_2       <chr> "1", "6", "6", "3", "3", "6", "5", "4", "5",...
    ## $ ImplicitB_3       <chr> "6", "3", "2", "2", "4", "1", "2", "4", "4",...
    ## $ ImplicitB_4       <chr> "6", "2", "3", "3", "4", "1", "2", "4", "4",...
    ## $ ImplicitB_5       <chr> "4", "6", "4", "2", "3", "6", "5", "1", "5",...
    ## $ ImplicitB_6       <chr> "6", "2", "4", "4", "4", "1", "2", "5", "4",...
    ## $ Workload_1        <chr> "16", "18", "12", "15", "5", "10", "11", "10...
    ## $ Workload_2        <chr> "12", "18", "2", "8", "1", "1", "1", "3", "1...
    ## $ Workload_3        <chr> "17", "10", "8", "2", "7", "1", "7", "3", "5...
    ## $ Workload_4        <chr> "14", "19", "16", "16", "21", "9", "11", "21...
    ## $ Workload_5        <chr> "16", "11", "17", "20", "5", "7", "15", "10"...
    ## $ Workload_6        <chr> "19", "13", "2", "2", "3", "13", "1", "3", "...
    ## $ Q10               <chr> "1", "1", "1", "1", "1", "1", "1", "1", "1",...
    ## $ LocationLatitude  <chr> "50.82460022", "50.82240295", "50.82460022",...
    ## $ LocationLongitude <chr> "-0.155502319", "-0.11050415", "-0.155502319...
    ## $ LocationAccuracy  <chr> "-1", "-1", "-1", "-1", "-1", "-1", "-1", "-...

``` r
names(df1)
```

    ##  [1] "V1"                "V2"                "V3"               
    ##  [4] "V4"                "V5"                "V6"               
    ##  [7] "V7"                "V8"                "V9"               
    ## [10] "V10"               "condition"         "InterInfo"        
    ## [13] "consentI"          "ContrInfo"         "consentC"         
    ## [16] "Q9"                "id"                "Q10"              
    ## [19] "MalleableC_1"      "MalleableC_2"      "MalleableC_3"     
    ## [22] "MalleableC_4"      "Expect_1"          "Expect_2"         
    ## [25] "Expect_3"          "ImplicitB_1"       "ImplicitB_2"      
    ## [28] "ImplicitB_3"       "ImplicitB_4"       "ImplicitB_5"      
    ## [31] "ImplicitB_6"       "Workload_1"        "Workload_2"       
    ## [34] "Workload_3"        "Workload_4"        "Workload_5"       
    ## [37] "Workload_6"        "Q10"               "LocationLatitude" 
    ## [40] "LocationLongitude" "LocationAccuracy"

Cleaning data. If my id variable is all in numbers, I often make sure they are numerics!

``` r
df1$id # not numeric
```

    ##   [1] "1"   "2"   "3"   "4"   "5"   "6"   "7"   "8"   "9"   "10"  "11" 
    ##  [12] "12"  "13"  "14"  "15"  "16"  "17"  "18"  "19"  "20"  "21"  "22" 
    ##  [23] "23"  "24"  "25"  "26"  "27"  "28"  "29"  "30"  "31"  "32"  "33" 
    ##  [34] "34"  "35"  "36"  "37"  "38"  "39"  "40"  "41"  "42"  "43"  "44" 
    ##  [45] "45"  "46"  "47"  "48"  "49"  "50"  "51"  "52"  "53"  "54"  "55" 
    ##  [56] "56"  "57"  "58"  "59"  "60"  "61"  "62"  "63"  "64"  "65"  "66" 
    ##  [67] "67"  "68"  "69"  "70"  "71"  "72"  "73"  "74"  "75"  "76"  "77" 
    ##  [78] "78"  "79"  "80"  "81"  "82"  "83"  "84"  "85"  "86"  "87"  "88" 
    ##  [89] "89"  "90"  "91"  "92"  "93"  "94"  "95"  "96"  "97"  "98"  "99" 
    ## [100] "100" "101" "102" "103" "104" "105" "106" "107" "108" "109" "110"
    ## [111] "111" "112" "113" "114" "115" "116" "117" "118" "119" "120" "121"
    ## [122] "122" "123" "124" "125" "126" "127" "128" "129" "130" "131" "132"
    ## [133] "133" "134" "135" "136" "137" "138" "139" "140" "141" "142" "143"
    ## [144] "144" "145" "146" "147" "148" "149" "150" "151" "152" "153" "154"
    ## [155] "155" "156" "157" "158" "159" "160" "161" "162" "163" "164" "165"
    ## [166] "166" "167" "168" "169" "170" "171" "172" "173" "174" "175" "176"
    ## [177] "177" "178" "179" "180" "181" "182" "183" "184" "185" "186" "187"
    ## [188] "188" "189" "190" "191" "192" "193" "194" "195" "196" "197" "198"
    ## [199] "199" "200" "201" "202" "203" "204" "205" "206" "207" "208" "209"
    ## [210] "210" "211" "212" "213" "214" "215" "216" "217" "218" "219" "220"
    ## [221] "221" "222" "223" "224" "225" "226" "227" "228" "229" "230" "231"
    ## [232] "232" "233" "234" "235" "236" "237" "238" "239" "240" "241" "242"
    ## [243] "243" "244" "245" "246" "247" "248" "249" "250" "251" "252" "253"
    ## [254] "254" "255" "256" "257" "258" "259" "260" "261" "262" "263" "264"
    ## [265] "265" "266" "267" "268" "269" "270" "271" "272" "273" "274" "275"
    ## [276] "276"

Convert to numerics by applying the `as.numeric()` function

``` r
df1[, id := as.numeric(id)] 
```

Select questionnaire items for relability analysis
--------------------------------------------------

-   use `select()` and `starts_with`, `matches()`, `contains()`, and `ends_with()` to select questionanire items for a scale

``` r
scale_implicitBeliefs <- select(df1, starts_with("ImplicitB"))
scale_implicitBeliefs
```

    ## Source: local data table [276 x 6]
    ## 
    ## # A tibble: 276 x 6
    ##    ImplicitB_1 ImplicitB_2 ImplicitB_3 ImplicitB_4 ImplicitB_5 ImplicitB_6
    ##    <chr>       <chr>       <chr>       <chr>       <chr>       <chr>      
    ##  1 1           1           6           6           4           6          
    ##  2 6           6           3           2           6           2          
    ##  3 6           6           2           3           4           4          
    ##  4 4           3           2           3           2           4          
    ##  5 3           3           4           4           3           4          
    ##  6 6           6           1           1           6           1          
    ##  7 4           5           2           2           5           2          
    ##  8 5           4           4           4           1           5          
    ##  9 5           5           4           4           5           4          
    ## 10 4           3           2           3           3           3          
    ## # ... with 266 more rows

Note that the variable types are all characters. Use `sapply()` (a loop) to loop through each column/variable, and convert them to `numeric` class.

``` r
scale_implicitBeliefs$ImplicitB_1 # all those quotation marks tell you it's a character
```

    ##   [1] "1" "6" "6" "4" "3" "6" "4" "5" "5" "4" "5" "5" "2" "3" "6" "5" "6"
    ##  [18] "5" "5" "3" "5" "2" "2" "6" "5" "5" "3" "5" "3" "6" "5" "6" "5" "6"
    ##  [35] "6" "5" "5" "6" "5" "2" "5" "4" "4" "5" "5" "2" "1" "2" "6" "6" "5"
    ##  [52] "5" "3" "4" "2" "6" "5" "3" "5" "5" "6" "5" "5" "5" "4" "5" "5" "4"
    ##  [69] "5" "6" "5" "3" "5" "6" "6" "5" "3" "5" "5" "6" "5" "6" "5" "4" "5"
    ##  [86] "3" "3" "5" "6" "3" "4" "4" "4" "4" "5" "6" "5" "5" "4" "4" "5" "6"
    ## [103] "4" "3" "4" "5" "5" "4" "4" "6" "4" "5" "4" "6" "3" "6" "4" "4" "3"
    ## [120] "6" "5" "3" "5" "5" "1" "5" "5" "5" "1" "5" "5" "4" "5" "5" "5" "4"
    ## [137] "5" "6" "5" "3" "6" "3" "3" "6" "4" "6" "3" "4" "4" "6" "5" "5" "3"
    ## [154] "6" "5" "4" "5" "2" "5" "4" "4" "5" "6" "5" "6" "5" "6" "2" "3" "4"
    ## [171] "2" "4" "5" "3" "5" "5" "4" "5" "3" "6" "5" "5" "5" "6" "5" "3" "4"
    ## [188] "6" "3" "4" "4" "5" "6" "4" "6" "4" "6" "5" "4" "2" "4" "5" "6" "6"
    ## [205] "4" "4" "3" "3" "6" "4" "5" "5" "5" "6" "5" "4" "6" "5" "5" "5" "3"
    ## [222] "5" "4" "3" "5" "4" "4" "5" "5" "5" "5" "6" "4" "2" "5" "3" "4" "6"
    ## [239] "4" "6" "4" "3" "6" "1" "6" "4" "4" "6" "4" "4" "4" "5" "4" "5" "5"
    ## [256] "6" "4" "4" "4" "4" "4" "4" "4" "5" "4" "4" "6" "6" "6" "6" "5" "4"
    ## [273] "5" "4" "5" "6"

``` r
scale_implicitBeliefsNumeric <- sapply(scale_implicitBeliefs, as.numeric) # convert to numeric (also a matrix)
scale_implicitBeliefsNumeric
```

    ##        ImplicitB_1 ImplicitB_2 ImplicitB_3 ImplicitB_4 ImplicitB_5
    ##   [1,]           1           1           6           6           4
    ##   [2,]           6           6           3           2           6
    ##   [3,]           6           6           2           3           4
    ##   [4,]           4           3           2           3           2
    ##   [5,]           3           3           4           4           3
    ##   [6,]           6           6           1           1           6
    ##   [7,]           4           5           2           2           5
    ##   [8,]           5           4           4           4           1
    ##   [9,]           5           5           4           4           5
    ##  [10,]           4           3           2           3           3
    ##  [11,]           5           4           3           3           4
    ##  [12,]           5           5           3           4           3
    ##  [13,]           2           3           2           4           3
    ##  [14,]           3           3           2           2           3
    ##  [15,]           6           5           2           2           5
    ##  [16,]           5           5           2           2           2
    ##  [17,]           6           6           3           2           5
    ##  [18,]           5           5           3           3           3
    ##  [19,]           5           3           3           2           5
    ##  [20,]           3           4           2           2           4
    ##  [21,]           5           5           3           2           4
    ##  [22,]           2           2           4           5           2
    ##  [23,]           2           4           4           5           3
    ##  [24,]           6           5           2           2           5
    ##  [25,]           5           4           3           3           4
    ##  [26,]           5           5           3           3           4
    ##  [27,]           3           3           4           5           3
    ##  [28,]           5           5           2           2           4
    ##  [29,]           3           3           4           5           2
    ##  [30,]           6           4           4           3           4
    ##  [31,]           5           5           2           4           3
    ##  [32,]           6           5           2           2           4
    ##  [33,]           5           5           2           2           5
    ##  [34,]           6           6           1           5           5
    ##  [35,]           6           5           3           2           5
    ##  [36,]           5           4           5           3           4
    ##  [37,]           5           4           2           2           5
    ##  [38,]           6           6           2           2           6
    ##  [39,]           5           5           2           2           5
    ##  [40,]           2           1           5           5           2
    ##  [41,]           5           5           3           3           5
    ##  [42,]           4           4           3           2           4
    ##  [43,]           4           5           2           3           5
    ##  [44,]           5           5           2           3           5
    ##  [45,]           5           4           3           3           4
    ##  [46,]           2           3           3           3           3
    ##  [47,]           1           2           3           3           3
    ##  [48,]           2           2           2           4           3
    ##  [49,]           6           6           1           1           6
    ##  [50,]           6           6           1           1           6
    ##  [51,]           5           5           2           1           4
    ##  [52,]           5           5           5           5           3
    ##  [53,]           3           3           1           4           3
    ##  [54,]           4           3           3           2           4
    ##  [55,]           2           2           5           5           2
    ##  [56,]           6           6           1           1           6
    ##  [57,]           5           5           2           2           4
    ##  [58,]           3           4           4           4           3
    ##  [59,]           5           5           1           1           5
    ##  [60,]           5           3           4           4           6
    ##  [61,]           6           6           1           2           5
    ##  [62,]           5           5           3           2           5
    ##  [63,]           5           3           4           3           5
    ##  [64,]           5           4           2           3           6
    ##  [65,]           4           6           3           1           3
    ##  [66,]           5           4           3           2           3
    ##  [67,]           5           5           2           2           5
    ##  [68,]           4           2           3           3           2
    ##  [69,]           5           5           4           3           4
    ##  [70,]           6           6           1           3           6
    ##  [71,]           5           5           2           2           5
    ##  [72,]           3           3           4           4           2
    ##  [73,]           5           5           2           3           4
    ##  [74,]           6           6           2           2           3
    ##  [75,]           6           6           2           2           5
    ##  [76,]           5           5           2           2           5
    ##  [77,]           3           3           4           4           3
    ##  [78,]           5           5           6           3           4
    ##  [79,]           5           5           2           2           4
    ##  [80,]           6           2           3           3           4
    ##  [81,]           5           5           2           2           5
    ##  [82,]           6           6           2           2           6
    ##  [83,]           5           5           2           2           5
    ##  [84,]           4           2           2           3           5
    ##  [85,]           5           5           3           3           4
    ##  [86,]           3           2           4           6           2
    ##  [87,]           3           3           4           3           4
    ##  [88,]           5           5           2           2           3
    ##  [89,]           6           5           2           1           5
    ##  [90,]           3           6           1           5           6
    ##  [91,]           4           3           2           2           4
    ##  [92,]           4           4           2           2           4
    ##  [93,]           4           4           2           2           2
    ##  [94,]           4           4           3           2           5
    ##  [95,]           5           5           2           2           5
    ##  [96,]           6           4           2           1           3
    ##  [97,]           5           4           3           3           2
    ##  [98,]           5           5           3           3           4
    ##  [99,]           4           4           3           3           3
    ## [100,]           4           4           3           3           4
    ## [101,]           5           4           3           3           5
    ## [102,]           6           5           2           2           3
    ## [103,]           4           4           3           4           4
    ## [104,]           3           2           5           5           2
    ## [105,]           4           4           4           4           3
    ## [106,]           5           5           2           3           5
    ## [107,]           5           5           2           2           2
    ## [108,]           4           4           4           4           4
    ## [109,]           4           3           2           3           2
    ## [110,]           6           6           1           1           6
    ## [111,]           4           4           2           1           4
    ## [112,]           5           2           4           3           2
    ## [113,]           4           5           4           4           4
    ## [114,]           6           5           3           2           5
    ## [115,]           3           3           4           3           2
    ## [116,]           6           3           4           2           4
    ## [117,]           4           4           4           3           4
    ## [118,]           4           4           2           2           5
    ## [119,]           3           4           5           5           2
    ## [120,]           6           6           1           5           6
    ## [121,]           5           5           5           5           3
    ## [122,]           3           2           4           5           3
    ## [123,]           5           4           2           2           5
    ## [124,]           5           4           3           3           5
    ## [125,]           1           1           3           6           1
    ## [126,]           5           5           2           2           5
    ## [127,]           5           3           3           2           4
    ## [128,]           5           5           5           5           5
    ## [129,]           1           1           6           6           1
    ## [130,]           5           5           4           3           4
    ## [131,]           5           5           2           2           5
    ## [132,]           4           3           3           3           4
    ## [133,]           5           5           2           3           5
    ## [134,]           5           3           4           3           4
    ## [135,]           5           5           2           2           5
    ## [136,]           4           4           4           3           3
    ## [137,]           5           4           2           2           4
    ## [138,]           6           6           2           1           6
    ## [139,]           5           4           4           3           5
    ## [140,]           3           5           6           4           1
    ## [141,]           6           6           2           2           5
    ## [142,]           3           4           4           3           4
    ## [143,]           3           4           2           3           6
    ## [144,]           6           5           3           3           4
    ## [145,]           4           4           2           2           5
    ## [146,]           6           5           1           5           6
    ## [147,]           3           4           3           2           4
    ## [148,]           4           4           2           2           5
    ## [149,]           4           4           3           3           4
    ## [150,]           6           6           2           3           6
    ## [151,]           5           5           5           4           4
    ## [152,]           5           6           2           2           6
    ## [153,]           3           3           5           5           3
    ## [154,]           6           6           4           2           4
    ## [155,]           5           4           2           3           3
    ## [156,]           4           5           3           3           4
    ## [157,]           5           5           3           2           3
    ## [158,]           2           3           4           4           3
    ## [159,]           5           3           4           4           3
    ## [160,]           4           3           3           3           3
    ## [161,]           4           5           3           4           3
    ## [162,]           5           4           3           3           2
    ## [163,]           6           2           6           6           1
    ## [164,]           5           5           2           2           3
    ## [165,]           6           6           2           2           6
    ## [166,]           5           5           2           2           5
    ## [167,]           6           5           2           2           5
    ## [168,]           2           3           4           5           2
    ## [169,]           3           3           4           4           3
    ## [170,]           4           2           5           5           2
    ## [171,]           2           2           4           3           3
    ## [172,]           4           5           3           3           4
    ## [173,]           5           5           3           3           5
    ## [174,]           3           3           5           3           3
    ## [175,]           5           5           2           2           5
    ## [176,]           5           5           2           2           4
    ## [177,]           4           3           6           5           1
    ## [178,]           5           4           2           2           5
    ## [179,]           3           5           3           3           4
    ## [180,]           6           5           1           1           6
    ## [181,]           5           5           2           3           4
    ## [182,]           5           4           3           4           4
    ## [183,]           5           4           3           3           5
    ## [184,]           6           6           3           3           3
    ## [185,]           5           5           3           3           4
    ## [186,]           3           3           3           1           5
    ## [187,]           4           4           3           3           4
    ## [188,]           6           6           1           1           6
    ## [189,]           3           4           4           4           3
    ## [190,]           4           2           5           3           2
    ## [191,]           4           5           4           3           5
    ## [192,]           5           5           2           2           5
    ## [193,]           6           6           1           2           6
    ## [194,]           4           4           3           3           4
    ## [195,]           6           4           4           4           2
    ## [196,]           4           5           3           3           4
    ## [197,]           6           5           3           2           3
    ## [198,]           5           5           2           3           6
    ## [199,]           4           3           3           3           4
    ## [200,]           2           2           5           5           2
    ## [201,]           4           4           3           3           4
    ## [202,]           5           5           1           1           5
    ## [203,]           6           5           2           1           6
    ## [204,]           6           6           1           2           5
    ## [205,]           4           2           3           3           4
    ## [206,]           4           4           2           2           3
    ## [207,]           3           3           3           3           3
    ## [208,]           3           2           3           3           2
    ## [209,]           6           6           1           1           6
    ## [210,]           4           4           3           4           3
    ## [211,]           5           5           2           2           4
    ## [212,]           5           4           3           3           5
    ## [213,]           5           5           2           2           6
    ## [214,]           6           5           3           3           4
    ## [215,]           5           5           3           4           5
    ## [216,]           4           4           3           2           5
    ## [217,]           6           6           2           2           6
    ## [218,]           5           5           2           3           5
    ## [219,]           5           5           2           2           3
    ## [220,]           5           6           5           3           4
    ## [221,]           3           5           4           4           3
    ## [222,]           5           5           3           3           5
    ## [223,]           4           5           5           3           4
    ## [224,]           3           4           3           3           2
    ## [225,]           5           3           3           3           4
    ## [226,]           4           4           2           2           3
    ## [227,]           4           4           3           3           4
    ## [228,]           5           4           2           3           4
    ## [229,]           5           5           1           1           6
    ## [230,]           5           5           2           3           5
    ## [231,]           5           4           2           3           5
    ## [232,]           6           5           3           4           5
    ## [233,]           4           3           4           4           3
    ## [234,]           2           3           4           4           2
    ## [235,]           5           5           2           3           4
    ## [236,]           3           3           2           3           2
    ## [237,]           4           4           2           2           4
    ## [238,]           6           6           2           2           4
    ## [239,]           4           4           3           3           4
    ## [240,]           6           6           4           3           4
    ## [241,]           4           2           3           2           4
    ## [242,]           3           5           4           3           4
    ## [243,]           6           6           2           2           6
    ## [244,]           1           1           5           5           1
    ## [245,]           6           6           2           2           4
    ## [246,]           4           5           1           1           6
    ## [247,]           4           4           2           2           4
    ## [248,]           6           3           5           3           3
    ## [249,]           4           5           3           2           5
    ## [250,]           4           3           3           5           2
    ## [251,]           4           3           4           4           2
    ## [252,]           5           5           3           2           4
    ## [253,]           4           4           3           3           5
    ## [254,]           5           5           4           4           4
    ## [255,]           5           5           2           4           5
    ## [256,]           6           6           1           1           6
    ## [257,]           4           4           3           3           4
    ## [258,]           4           4           3           2           4
    ## [259,]           4           4           2           2           4
    ## [260,]           4           3           4           2           6
    ## [261,]           4           4           2           3           5
    ## [262,]           4           4           3           4           4
    ## [263,]           4           3           5           4           3
    ## [264,]           5           4           4           3           4
    ## [265,]           4           3           4           4           5
    ## [266,]           4           5           3           3           4
    ## [267,]           6           6           1           1           6
    ## [268,]           6           2           2           2           5
    ## [269,]           6           6           2           2           6
    ## [270,]           6           6           1           1           5
    ## [271,]           5           5           4           4           5
    ## [272,]           4           4           2           2           4
    ## [273,]           5           5           1           2           5
    ## [274,]           4           5           2           2           5
    ## [275,]           5           5           4           4           2
    ## [276,]           6           6           1           4           3
    ##        ImplicitB_6
    ##   [1,]           6
    ##   [2,]           2
    ##   [3,]           4
    ##   [4,]           4
    ##   [5,]           4
    ##   [6,]           1
    ##   [7,]           2
    ##   [8,]           5
    ##   [9,]           4
    ##  [10,]           3
    ##  [11,]           3
    ##  [12,]           3
    ##  [13,]           3
    ##  [14,]           2
    ##  [15,]           2
    ##  [16,]           3
    ##  [17,]           5
    ##  [18,]           4
    ##  [19,]           2
    ##  [20,]           3
    ##  [21,]           3
    ##  [22,]           5
    ##  [23,]           4
    ##  [24,]           3
    ##  [25,]           4
    ##  [26,]           4
    ##  [27,]           5
    ##  [28,]           2
    ##  [29,]           5
    ##  [30,]           5
    ##  [31,]           3
    ##  [32,]           2
    ##  [33,]           3
    ##  [34,]           3
    ##  [35,]           2
    ##  [36,]           3
    ##  [37,]           2
    ##  [38,]           6
    ##  [39,]           2
    ##  [40,]           4
    ##  [41,]           3
    ##  [42,]           3
    ##  [43,]           2
    ##  [44,]           2
    ##  [45,]           3
    ##  [46,]           3
    ##  [47,]           3
    ##  [48,]           3
    ##  [49,]           1
    ##  [50,]           1
    ##  [51,]           2
    ##  [52,]           4
    ##  [53,]           2
    ##  [54,]           2
    ##  [55,]           6
    ##  [56,]           1
    ##  [57,]           2
    ##  [58,]           3
    ##  [59,]           1
    ##  [60,]           6
    ##  [61,]           2
    ##  [62,]           3
    ##  [63,]           5
    ##  [64,]           3
    ##  [65,]           2
    ##  [66,]           3
    ##  [67,]           3
    ##  [68,]           4
    ##  [69,]           3
    ##  [70,]           1
    ##  [71,]           2
    ##  [72,]           4
    ##  [73,]           2
    ##  [74,]           3
    ##  [75,]           2
    ##  [76,]           3
    ##  [77,]           4
    ##  [78,]           5
    ##  [79,]           3
    ##  [80,]           4
    ##  [81,]           2
    ##  [82,]           3
    ##  [83,]           2
    ##  [84,]           3
    ##  [85,]           3
    ##  [86,]           6
    ##  [87,]           3
    ##  [88,]           1
    ##  [89,]           2
    ##  [90,]           2
    ##  [91,]           2
    ##  [92,]           2
    ##  [93,]           1
    ##  [94,]           5
    ##  [95,]           2
    ##  [96,]           4
    ##  [97,]           4
    ##  [98,]           3
    ##  [99,]           3
    ## [100,]           3
    ## [101,]           4
    ## [102,]           3
    ## [103,]           3
    ## [104,]           5
    ## [105,]           4
    ## [106,]           3
    ## [107,]           2
    ## [108,]           4
    ## [109,]           2
    ## [110,]           1
    ## [111,]           2
    ## [112,]           3
    ## [113,]           4
    ## [114,]           1
    ## [115,]           3
    ## [116,]           2
    ## [117,]           3
    ## [118,]           2
    ## [119,]           5
    ## [120,]           1
    ## [121,]           3
    ## [122,]           4
    ## [123,]           2
    ## [124,]           5
    ## [125,]           3
    ## [126,]           4
    ## [127,]           3
    ## [128,]           5
    ## [129,]           6
    ## [130,]           3
    ## [131,]           2
    ## [132,]           4
    ## [133,]           2
    ## [134,]           4
    ## [135,]           2
    ## [136,]           4
    ## [137,]           3
    ## [138,]           1
    ## [139,]           3
    ## [140,]           3
    ## [141,]           2
    ## [142,]           5
    ## [143,]           3
    ## [144,]           3
    ## [145,]           3
    ## [146,]           5
    ## [147,]           3
    ## [148,]           2
    ## [149,]           3
    ## [150,]           2
    ## [151,]           4
    ## [152,]           6
    ## [153,]           5
    ## [154,]           2
    ## [155,]           2
    ## [156,]           4
    ## [157,]           2
    ## [158,]           4
    ## [159,]           5
    ## [160,]           4
    ## [161,]           4
    ## [162,]           4
    ## [163,]           6
    ## [164,]           2
    ## [165,]           2
    ## [166,]           2
    ## [167,]           3
    ## [168,]           5
    ## [169,]           4
    ## [170,]           5
    ## [171,]           4
    ## [172,]           3
    ## [173,]           2
    ## [174,]           4
    ## [175,]           2
    ## [176,]           2
    ## [177,]           5
    ## [178,]           3
    ## [179,]           3
    ## [180,]           1
    ## [181,]           3
    ## [182,]           4
    ## [183,]           4
    ## [184,]           2
    ## [185,]           3
    ## [186,]           3
    ## [187,]           3
    ## [188,]           1
    ## [189,]           3
    ## [190,]           4
    ## [191,]           2
    ## [192,]           3
    ## [193,]           2
    ## [194,]           2
    ## [195,]           3
    ## [196,]           3
    ## [197,]           3
    ## [198,]           3
    ## [199,]           3
    ## [200,]           4
    ## [201,]           4
    ## [202,]           2
    ## [203,]           2
    ## [204,]           2
    ## [205,]           3
    ## [206,]           2
    ## [207,]           3
    ## [208,]           3
    ## [209,]           1
    ## [210,]           3
    ## [211,]           4
    ## [212,]           2
    ## [213,]           2
    ## [214,]           3
    ## [215,]           3
    ## [216,]           2
    ## [217,]           2
    ## [218,]           2
    ## [219,]           2
    ## [220,]           3
    ## [221,]           4
    ## [222,]           3
    ## [223,]           4
    ## [224,]           3
    ## [225,]           3
    ## [226,]           3
    ## [227,]           4
    ## [228,]           2
    ## [229,]           2
    ## [230,]           2
    ## [231,]           3
    ## [232,]           4
    ## [233,]           3
    ## [234,]           5
    ## [235,]           2
    ## [236,]           2
    ## [237,]           2
    ## [238,]           4
    ## [239,]           3
    ## [240,]           2
    ## [241,]           3
    ## [242,]           4
    ## [243,]           2
    ## [244,]           5
    ## [245,]           2
    ## [246,]           2
    ## [247,]           2
    ## [248,]           4
    ## [249,]           2
    ## [250,]           4
    ## [251,]           4
    ## [252,]           3
    ## [253,]           4
    ## [254,]           4
    ## [255,]           3
    ## [256,]           1
    ## [257,]           3
    ## [258,]           3
    ## [259,]           2
    ## [260,]           5
    ## [261,]           3
    ## [262,]           5
    ## [263,]           5
    ## [264,]           4
    ## [265,]           3
    ## [266,]           2
    ## [267,]           2
    ## [268,]           2
    ## [269,]           2
    ## [270,]           1
    ## [271,]           2
    ## [272,]           2
    ## [273,]           2
    ## [274,]           2
    ## [275,]           4
    ## [276,]           5

I usually prefer to convert column classes using `data.table` syntax using `.SD` (*S*ubset of *D*atatable). Below, it's just saying, for every column in the `data.table`, convert it to numeric by applying the `as.numeric()` function to every column.

``` r
scale_implicitBeliefsNumeric <- scale_implicitBeliefs[, lapply(.SD, as.numeric)]
scale_implicitBeliefsNumeric
```

    ## Source: local data table [276 x 6]
    ## 
    ## # A tibble: 276 x 6
    ##    ImplicitB_1 ImplicitB_2 ImplicitB_3 ImplicitB_4 ImplicitB_5 ImplicitB_6
    ##          <dbl>       <dbl>       <dbl>       <dbl>       <dbl>       <dbl>
    ##  1           1           1           6           6           4           6
    ##  2           6           6           3           2           6           2
    ##  3           6           6           2           3           4           4
    ##  4           4           3           2           3           2           4
    ##  5           3           3           4           4           3           4
    ##  6           6           6           1           1           6           1
    ##  7           4           5           2           2           5           2
    ##  8           5           4           4           4           1           5
    ##  9           5           5           4           4           5           4
    ## 10           4           3           2           3           3           3
    ## # ... with 266 more rows

Run reliability analysis

``` r
library(psych) # psych package has the alpha() function to compute reliability
```

    ## 
    ## Attaching package: 'psych'

    ## The following objects are masked from 'package:ggplot2':
    ## 
    ##     %+%, alpha

``` r
scale_implicitBeliefsReliability <- alpha(scale_implicitBeliefsNumeric)
```

    ## Warning in alpha(scale_implicitBeliefsNumeric): Some items were negatively correlated with the total scale and probably 
    ## should be reversed.  
    ## To do this, run the function again with the 'check.keys=TRUE' option

    ## Some items ( ImplicitB_1 ImplicitB_2 ImplicitB_5 ) were negatively correlated with the total scale and 
    ## probably should be reversed.  
    ## To do this, run the function again with the 'check.keys=TRUE' option

``` r
scale_implicitBeliefsReliability
```

    ## 
    ## Reliability analysis   
    ## Call: alpha(x = scale_implicitBeliefsNumeric)
    ## 
    ##   raw_alpha std.alpha G6(smc) average_r   S/N  ase mean   sd median_r
    ##      -0.29     -0.29    0.42    -0.039 -0.22 0.14  3.6 0.44    -0.44
    ## 
    ##  lower alpha upper     95% confidence boundaries
    ## -0.56 -0.29 -0.03 
    ## 
    ##  Reliability if an item is dropped:
    ##             raw_alpha std.alpha G6(smc) average_r    S/N alpha se var.r
    ## ImplicitB_1     -0.38    -0.303    0.38    -0.049 -0.233     0.14  0.34
    ## ImplicitB_2     -0.28    -0.225    0.39    -0.038 -0.183     0.13  0.32
    ## ImplicitB_3     -0.17    -0.210    0.42    -0.036 -0.174     0.12  0.32
    ## ImplicitB_4     -0.16    -0.190    0.43    -0.033 -0.160     0.12  0.32
    ## ImplicitB_5     -0.11    -0.085    0.50    -0.016 -0.079     0.11  0.34
    ## ImplicitB_6     -0.33    -0.388    0.35    -0.059 -0.279     0.13  0.34
    ##             med.r
    ## ImplicitB_1 -0.45
    ## ImplicitB_2 -0.41
    ## ImplicitB_3 -0.41
    ## ImplicitB_4 -0.41
    ## ImplicitB_5 -0.41
    ## ImplicitB_6 -0.46
    ## 
    ##  Item statistics 
    ##               n raw.r std.r r.cor  r.drop mean  sd
    ## ImplicitB_1 276  0.45  0.41 0.305 -0.0028  4.5 1.2
    ## ImplicitB_2 276  0.41  0.36 0.262 -0.0629  4.3 1.2
    ## ImplicitB_3 276  0.31  0.36 0.241 -0.1407  2.8 1.2
    ## ImplicitB_4 276  0.29  0.34 0.212 -0.1450  2.9 1.1
    ## ImplicitB_5 276  0.32  0.26 0.036 -0.1749  4.0 1.3
    ## ImplicitB_6 276  0.42  0.46 0.377 -0.0316  3.0 1.2
    ## 
    ## Non missing response frequency for each item
    ##                1    2    3    4    5    6 miss
    ## ImplicitB_1 0.02 0.04 0.12 0.25 0.36 0.21    0
    ## ImplicitB_2 0.02 0.07 0.16 0.25 0.36 0.14    0
    ## ImplicitB_3 0.09 0.35 0.29 0.18 0.07 0.02    0
    ## ImplicitB_4 0.08 0.33 0.34 0.14 0.08 0.02    0
    ## ImplicitB_5 0.03 0.11 0.18 0.30 0.26 0.12    0
    ## ImplicitB_6 0.06 0.30 0.32 0.19 0.09 0.03    0

Very low reliabilty! The function warns you if it thinks certain items should be reverse-scored!

You can set `check.keys = T` to automatically reverse-score items!

``` r
scale_implicitBeliefsReliability <- alpha(scale_implicitBeliefsNumeric, check.keys = T) # automatically reverse-scores items if necessary
```

    ## Warning in alpha(scale_implicitBeliefsNumeric, check.keys = T): Some items were negatively correlated with total scale and were automatically reversed.
    ##  This is indicated by a negative sign for the variable name.

``` r
scale_implicitBeliefsReliability
```

    ## 
    ## Reliability analysis   
    ## Call: alpha(x = scale_implicitBeliefsNumeric, check.keys = T)
    ## 
    ##   raw_alpha std.alpha G6(smc) average_r S/N   ase mean   sd median_r
    ##       0.87      0.87    0.87      0.54   7 0.012  2.8 0.93     0.53
    ## 
    ##  lower alpha upper     95% confidence boundaries
    ## 0.85 0.87 0.9 
    ## 
    ##  Reliability if an item is dropped:
    ##              raw_alpha std.alpha G6(smc) average_r S/N alpha se  var.r
    ## ImplicitB_1-      0.86      0.86    0.84      0.55 6.2    0.014 0.0059
    ## ImplicitB_2-      0.85      0.85    0.83      0.53 5.7    0.014 0.0092
    ## ImplicitB_3       0.85      0.85    0.84      0.53 5.6    0.015 0.0089
    ## ImplicitB_4       0.85      0.85    0.84      0.53 5.6    0.015 0.0101
    ## ImplicitB_5-      0.85      0.86    0.85      0.54 5.9    0.014 0.0115
    ## ImplicitB_6       0.86      0.86    0.85      0.55 6.1    0.014 0.0055
    ##              med.r
    ## ImplicitB_1-  0.55
    ## ImplicitB_2-  0.54
    ## ImplicitB_3   0.52
    ## ImplicitB_4   0.52
    ## ImplicitB_5-  0.51
    ## ImplicitB_6   0.54
    ## 
    ##  Item statistics 
    ##                n raw.r std.r r.cor r.drop mean  sd
    ## ImplicitB_1- 276  0.75  0.75  0.70   0.64  2.5 1.2
    ## ImplicitB_2- 276  0.80  0.80  0.75   0.70  2.7 1.2
    ## ImplicitB_3  276  0.81  0.81  0.77   0.71  2.8 1.2
    ## ImplicitB_4  276  0.80  0.81  0.76   0.71  2.9 1.1
    ## ImplicitB_5- 276  0.78  0.78  0.71   0.67  3.0 1.3
    ## ImplicitB_6  276  0.76  0.76  0.71   0.64  3.0 1.2
    ## 
    ## Non missing response frequency for each item
    ##                1    2    3    4    5    6 miss
    ## ImplicitB_1 0.02 0.04 0.12 0.25 0.36 0.21    0
    ## ImplicitB_2 0.02 0.07 0.16 0.25 0.36 0.14    0
    ## ImplicitB_3 0.09 0.35 0.29 0.18 0.07 0.02    0
    ## ImplicitB_4 0.08 0.33 0.34 0.14 0.08 0.02    0
    ## ImplicitB_5 0.03 0.11 0.18 0.30 0.26 0.12    0
    ## ImplicitB_6 0.06 0.30 0.32 0.19 0.09 0.03    0

Now reliability is much higher!

Use `cleanQuestionnaire()` function instead
-------------------------------------------

What if you want to compute each subject's scale mean? You can use `data.table` and `tidyverse` to do it. But with many scales, it can get tedious. Hence, I've written the `cleanQuestionnaire()` to automate certain steps. To use the function, first run `source('https://raw.githubusercontent.com/hauselin/Rcode/master/cleanQuestionnaire.R')` to get the function. Check out the actual [website itself](https://raw.githubusercontent.com/hauselin/Rcode/master/cleanQuestionnaire.R) if you wanto read the documentation of the function.

``` r
source("https://raw.githubusercontent.com/hauselin/Rcode/master/cleanQuestionnaire.R")
```

Select data. Make sure the first column is subject id, and subsequent columns are items for a specific scale

-   select id column (required)
-   select items of a particular scale

``` r
scale_implicitBeliefs <- select(df1, id, starts_with("ImplicitB"))
scale_implicitBeliefs
```

    ## Source: local data table [276 x 7]
    ## 
    ## # A tibble: 276 x 7
    ##       id ImplicitB_1 ImplicitB_2 ImplicitB_3 ImplicitB_4 ImplicitB_5
    ##    <dbl> <chr>       <chr>       <chr>       <chr>       <chr>      
    ##  1     1 1           1           6           6           4          
    ##  2     2 6           6           3           2           6          
    ##  3     3 6           6           2           3           4          
    ##  4     4 4           3           2           3           2          
    ##  5     5 3           3           4           4           3          
    ##  6     6 6           6           1           1           6          
    ##  7     7 4           5           2           2           5          
    ##  8     8 5           4           4           4           1          
    ##  9     9 5           5           4           4           5          
    ## 10    10 4           3           2           3           3          
    ## # ... with 266 more rows, and 1 more variable: ImplicitB_6 <chr>

Convert all columns to numeric

``` r
scale_implicitBeliefs <- scale_implicitBeliefs[, lapply(.SD, as.numeric)]
scale_implicitBeliefs
```

    ## Source: local data table [276 x 7]
    ## 
    ## # A tibble: 276 x 7
    ##       id ImplicitB_1 ImplicitB_2 ImplicitB_3 ImplicitB_4 ImplicitB_5
    ##    <dbl>       <dbl>       <dbl>       <dbl>       <dbl>       <dbl>
    ##  1     1           1           1           6           6           4
    ##  2     2           6           6           3           2           6
    ##  3     3           6           6           2           3           4
    ##  4     4           4           3           2           3           2
    ##  5     5           3           3           4           4           3
    ##  6     6           6           6           1           1           6
    ##  7     7           4           5           2           2           5
    ##  8     8           5           4           4           4           1
    ##  9     9           5           5           4           4           5
    ## 10    10           4           3           2           3           3
    ## # ... with 266 more rows, and 1 more variable: ImplicitB_6 <dbl>

Run `cleanQuestionnaire()` function

The function will double-check with you regarding which items to reverse-code, and which subscale an item belongs to. If everything looks correct, press 1 and hit enter to continue.

The function accepts characters AND numerics scale items!

More documentation to follow [here](https://github.com/hauselin/Rcode) in the near future...

Function arguments

-   data: data containing subject id and scale items (wide form)
-   subjectCol: indicate which column contains subject id (default = 1)
-   scaleName: give your scale a good name
-   scaleMin: what's the scale mininum
-   scaleMax: what's the scale maximum
-   subscales: use a list() to specify item numbers for each subscale (if no subscale, just don't specify this subscales argument)
-   itemsToReverse: item numbers to reverse-code
-   checkReliability: T or F (whether to do reliability analysis) (does it separately for each subscale)

``` r
scale_implicitBeliefs_clean <- cleanQuestionnaire(data = scale_implicitBeliefs, subjectCol = 1, scaleName = "implicitBeliefs", scaleMin = 1, scaleMax = 6, subscales = list(implicitBeliefsA = c(1, 3, 5), implicitBeliefsB = c(2, 4, 6)), itemsToReverse = c(1, 2, 5), checkReliability = T)
```

The output is a `list` class.

``` r
class(scale_implicitBeliefs_clean)
```

    ## [1] "list"

``` r
names(scale_implicitBeliefs_clean)
```

    ## [1] "wide"        "long"        "reliability"

It contains the wide data, long data, and reliability results. To subset lists, use `$` to extract by name.

Get wide data: id variable, scale overall mean, and all subscale means

``` r
scale_implicitBeliefs_clean$wide
```

    ## Source: local data table [276 x 4]
    ## 
    ## # A tibble: 276 x 4
    ##       id implicitBeliefs_m_overall implicitBeliefs_m_… implicitBeliefs_m_…
    ##  * <dbl>                     <dbl>               <dbl>               <dbl>
    ##  1     1                      5.5                 5                   6   
    ##  2     2                      1.67                1.67                1.67
    ##  3     3                      2.33                2                   2.67
    ##  4     4                      3.5                 3.33                3.67
    ##  5     5                      4                   4                   4   
    ##  6     6                      1                   1                   1   
    ##  7     7                      2.17                2.33                2   
    ##  8     8                      4                   4                   4   
    ##  9     9                      3                   2.67                3.33
    ## 10    10                      3.17                3                   3.33
    ## # ... with 266 more rows

Get long data: id variable, scale/subscale means (\_m), standard deviations (\_stdev), and range (\_rge)

``` r
scale_implicitBeliefs_clean$long
```

    ## Source: local data table [828 x 6]
    ## 
    ## # A tibble: 828 x 6
    ##       id implicitBeliefs_m implicitBeliefs_stdev implicitBeliefs_rge
    ##    <dbl>             <dbl>                 <dbl>               <dbl>
    ##  1     1              5.5                  1.22                    3
    ##  2     1              5                    1.73                    3
    ##  3     1              6                    0                       0
    ##  4     2              1.67                 0.816                   2
    ##  5     2              1.67                 1.15                    2
    ##  6     2              1.67                 0.577                   1
    ##  7     3              2.33                 1.21                    3
    ##  8     3              2                    1                       2
    ##  9     3              2.67                 1.53                    3
    ## 10     4              3.5                  1.05                    3
    ## # ... with 818 more rows, and 2 more variables:
    ## #   implicitBeliefs_items <int>, implicitBeliefs_subscale <chr>

Get reliablity results (one set of results for each subscale)

``` r
scale_implicitBeliefs_clean$reliability
```

    ## $implicitBeliefsA
    ## 
    ## Reliability analysis   
    ## Call: psych::alpha(x = tempData, check.keys = TRUE)
    ## 
    ##   raw_alpha std.alpha G6(smc) average_r S/N   ase mean   sd median_r
    ##       0.76      0.76    0.68      0.51 3.1 0.025  2.8 0.99     0.53
    ## 
    ##  lower alpha upper     95% confidence boundaries
    ## 0.71 0.76 0.81 
    ## 
    ##  Reliability if an item is dropped:
    ##             raw_alpha std.alpha G6(smc) average_r S/N alpha se var.r med.r
    ## ImplicitB_1      0.72      0.72    0.56      0.56 2.6    0.034    NA  0.56
    ## ImplicitB_3      0.70      0.70    0.53      0.53 2.3    0.037    NA  0.53
    ## ImplicitB_5      0.61      0.61    0.44      0.44 1.6    0.047    NA  0.44
    ## 
    ##  Item statistics 
    ##               n raw.r std.r r.cor r.drop mean  sd
    ## ImplicitB_1 276  0.80  0.80  0.63   0.55  2.5 1.2
    ## ImplicitB_3 276  0.81  0.81  0.66   0.57  2.8 1.2
    ## ImplicitB_5 276  0.86  0.85  0.74   0.64  3.0 1.3
    ## 
    ## Non missing response frequency for each item
    ##                1    2    3    4    5    6 miss
    ## ImplicitB_1 0.21 0.36 0.25 0.12 0.04 0.02    0
    ## ImplicitB_3 0.09 0.35 0.29 0.18 0.07 0.02    0
    ## ImplicitB_5 0.12 0.26 0.30 0.18 0.11 0.03    0
    ## 
    ## $implicitBeliefsB
    ## 
    ## Reliability analysis   
    ## Call: psych::alpha(x = tempData, check.keys = TRUE)
    ## 
    ##   raw_alpha std.alpha G6(smc) average_r S/N   ase mean   sd median_r
    ##       0.77      0.77    0.71      0.53 3.4 0.024  2.9 0.97     0.49
    ## 
    ##  lower alpha upper     95% confidence boundaries
    ## 0.73 0.77 0.82 
    ## 
    ##  Reliability if an item is dropped:
    ##             raw_alpha std.alpha G6(smc) average_r S/N alpha se var.r med.r
    ## ImplicitB_2      0.78      0.78    0.64      0.64 3.6    0.026    NA  0.64
    ## ImplicitB_4      0.64      0.64    0.47      0.47 1.8    0.043    NA  0.47
    ## ImplicitB_6      0.66      0.66    0.49      0.49 1.9    0.041    NA  0.49
    ## 
    ##  Item statistics 
    ##               n raw.r std.r r.cor r.drop mean  sd
    ## ImplicitB_2 276  0.79  0.79  0.59   0.53  2.7 1.2
    ## ImplicitB_4 276  0.85  0.85  0.76   0.66  2.9 1.1
    ## ImplicitB_6 276  0.85  0.85  0.74   0.64  3.0 1.2
    ## 
    ## Non missing response frequency for each item
    ##                1    2    3    4    5    6 miss
    ## ImplicitB_2 0.14 0.36 0.25 0.16 0.07 0.02    0
    ## ImplicitB_4 0.08 0.33 0.34 0.14 0.08 0.02    0
    ## ImplicitB_6 0.06 0.30 0.32 0.19 0.09 0.03    0

Another `cleanQuestionnaire()` example
--------------------------------------

Select data. Make sure the first column is subject id, and subsequent columns are items for a specific scale

-   select id column (required)
-   select items of a particular scale

``` r
scale_workload <- select(df1, id, starts_with("Workload"))
scale_workload
```

    ## Source: local data table [276 x 7]
    ## 
    ## # A tibble: 276 x 7
    ##       id Workload_1 Workload_2 Workload_3 Workload_4 Workload_5 Workload_6
    ##    <dbl> <chr>      <chr>      <chr>      <chr>      <chr>      <chr>     
    ##  1     1 16         12         17         14         16         19        
    ##  2     2 18         18         10         19         11         13        
    ##  3     3 12         2          8          16         17         2         
    ##  4     4 15         8          2          16         20         2         
    ##  5     5 5          1          7          21         5          3         
    ##  6     6 10         1          1          9          7          13        
    ##  7     7 11         1          7          11         15         1         
    ##  8     8 10         3          3          21         10         3         
    ##  9     9 14         13         5          21         12         3         
    ## 10    10 16         12         10         17         16         4         
    ## # ... with 266 more rows

Run function

-   no subscales, 1 item to reverse

``` r
scale_workload_clean <- cleanQuestionnaire(data = scale_workload, subjectCol = 1, scaleName = "workload", scaleMin = 1, scaleMax = 21, itemsToReverse = c(4), checkReliability = T)
```

Check results

``` r
scale_workload_clean$wide
```

    ## Source: local data table [276 x 2]
    ## 
    ## # A tibble: 276 x 2
    ##       id workload_m_overall
    ##  * <dbl>              <dbl>
    ##  1     1              14.7 
    ##  2     2              12.2 
    ##  3     3               7.83
    ##  4     4               8.83
    ##  5     5               3.67
    ##  6     6               7.5 
    ##  7     7               7.67
    ##  8     8               5   
    ##  9     9               8   
    ## 10    10              10.5 
    ## # ... with 266 more rows

``` r
scale_workload_clean$long
```

    ## Source: local data table [276 x 6]
    ## 
    ## # A tibble: 276 x 6
    ##       id workload_m workload_stdev workload_rge workload_items
    ##    <dbl>      <dbl>          <dbl>        <dbl>          <int>
    ##  1     1      14.7            3.98           11              6
    ##  2     2      12.2            5.64           15              6
    ##  3     3       7.83           5.88           15              6
    ##  4     4       8.83           7.28           18              6
    ##  5     5       3.67           2.42            6              6
    ##  6     6       7.5            5.50           12              6
    ##  7     7       7.67           5.75           14              6
    ##  8     8       5              3.95            9              6
    ##  9     9       8              5.66           13              6
    ## 10    10      10.5            5.21           12              6
    ## # ... with 266 more rows, and 1 more variable: workload_subscale <chr>

``` r
scale_workload_clean$reliability
```

    ## $workload
    ## 
    ## Reliability analysis   
    ## Call: psych::alpha(x = tempData, check.keys = TRUE)
    ## 
    ##   raw_alpha std.alpha G6(smc) average_r S/N   ase mean  sd median_r
    ##       0.67      0.66    0.66      0.24 1.9 0.029  8.2 2.7     0.22
    ## 
    ##  lower alpha upper     95% confidence boundaries
    ## 0.61 0.67 0.73 
    ## 
    ##  Reliability if an item is dropped:
    ##            raw_alpha std.alpha G6(smc) average_r S/N alpha se var.r med.r
    ## Workload_1      0.62      0.60    0.58      0.23 1.5    0.035 0.026  0.20
    ## Workload_2      0.60      0.58    0.58      0.22 1.4    0.036 0.030  0.21
    ## Workload_3      0.64      0.63    0.63      0.25 1.7    0.032 0.046  0.31
    ## Workload_4      0.72      0.72    0.69      0.34 2.5    0.026 0.013  0.35
    ## Workload_5      0.58      0.57    0.55      0.21 1.3    0.038 0.023  0.22
    ## Workload_6      0.59      0.57    0.57      0.21 1.3    0.038 0.039  0.20
    ## 
    ##  Item statistics 
    ##              n raw.r std.r r.cor r.drop mean  sd
    ## Workload_1 276  0.62  0.64  0.56  0.446 11.6 3.7
    ## Workload_2 276  0.68  0.67  0.59  0.480  5.7 4.4
    ## Workload_3 276  0.57  0.59  0.44  0.361  7.2 4.1
    ## Workload_4 276  0.31  0.35  0.11  0.085  6.1 3.7
    ## Workload_5 276  0.72  0.70  0.65  0.524 11.1 4.6
    ## Workload_6 276  0.73  0.69  0.61  0.510  7.6 5.3

Joining and saving wide data from multiple scales
-------------------------------------------------

Use `left_join()` to join two scales (both are wide form)

``` r
joined <- left_join(scale_implicitBeliefs_clean$wide, scale_workload_clean$wide, by = 'id')
joined
```

    ## Source: local data table [276 x 5]
    ## 
    ## # A tibble: 276 x 5
    ##       id implicitBeliefs_m_… implicitBeliefs_m_imp… implicitBeliefs_m_imp…
    ##    <dbl>               <dbl>                  <dbl>                  <dbl>
    ##  1     1                5.5                    5                      6   
    ##  2     2                1.67                   1.67                   1.67
    ##  3     3                2.33                   2                      2.67
    ##  4     4                3.5                    3.33                   3.67
    ##  5     5                4                      4                      4   
    ##  6     6                1                      1                      1   
    ##  7     7                2.17                   2.33                   2   
    ##  8     8                4                      4                      4   
    ##  9     9                3                      2.67                   3.33
    ## 10    10                3.17                   3                      3.33
    ## # ... with 266 more rows, and 1 more variable: workload_m_overall <dbl>

Save joined data as .rds object (one object at a time)
------------------------------------------------------

You can run the line below (without the \# sign) to save any object as a .rds file.

``` r
write_rds(joined, "scale_subject_means.rds") # save to your current directory
```

To read that back into R later on, use `read_rds()`

``` r
joined <- read_rds("scale_subject_means.rds") # read .rds file in your current directory into R
```

Save your entire workspace and all objects in environment as .RData (all objects)
---------------------------------------------------------------------------------

You can run the line below (without the \# sign) to save any object as a .RData file.

``` r
save.image("analysis_scales.RData") # save to your current directory
```

To read that back into R later on, use `load()`

``` r
load("analysis_scales.Rdata") # read .rds file in your current directory into R
```
