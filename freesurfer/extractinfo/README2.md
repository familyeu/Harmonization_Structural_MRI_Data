# Freesurfer Extract Info

[![Python Version](https://img.shields.io/badge/python-3.8%2B-blue)](https://www.python.org/)

Script: _FAMILY_extract_info_ENIGMA.py_

This Python script extracts basic FreeSurfer environment and quality information from a directory containing FreeSurfer outputs.

It generates a CSV file with one row per subject, with the columns:

|Variable|Description|
|---------|-------------|
|subject_dir | subject folder name|
|platform | operating system type |
|platform_version | kernel or OS version |
|freesurfer_release | exact FreeSurfer build/release string used |
|lh_surfaceholes | number of surface holes on the left hemisphere (quality metric)|
|rh_surfaceholes | number of surface holes on the right hemisphere (quality metric)|

---

## Requirements

- Python 3.8 or higher
- No external packages are needed, standard Python libraries only: `os`, `re`, `csv`, `argparse`, `logging`

---

## Installation

Clone this repository or download the script:

```bash
git clone https://github.com/familyeu/Harmonization_Structural_MRI_Data.git
```

## Usage

Navigate into the folder containing the script _Harmonization_Structural_MRI_Data/freesurfer/extractinfo/_
and run the script from the command line using Python:

```bash
cd /Harmonization_Structural_MRI_Data/freesurfer/extractinfo/
python3 subtract_info.py --fs_dir <path_to_freesurfer_output> --out_file <name_of_outputfile.csv>
```

## Example

The following code:

```bash
cd /Harmonization_Structural_MRI_Data/freesurfer/extractinfo/
python3 subtract_info.py --fs_dir /data/bids/derivatives/freesurfer/7.4.1 --out_file freesurfer_summary.csv
```
will generate the following CSV file:

|subject_dir |	platform |	platform_version	| freesurfer_release |	lh_surfaceholes |	rh_surfaceholes|
|---------|-------------|-------------|-------------|-------------|-------------|
|sub001	| Linux	| 5.14.0-427.76.1.el9_4.x86_64 | freesurfer-linux-centos8_x86_64-7.3.2-20220804-6354275	| 11	| 14|
|sub002 | Linux | 5.14.0-427.76.1.el9_4.x86_64 | freesurfer-linux-centos8_x86_64-7.3.2-20220804-6354275 | 48 | 58 |
