
### Folder Structure

- Each image used in an article resides in its **own folder** under `images/`:

```
images/
├── image_name_01/
│   ├── image.png          # screengrab or downloaded image
│   ├── url.txt            # URL of the source (e.g., Unsplash)
│   ├── license.txt        # License copy or notes
│   └── photographer.txt   # Optional, if known
```
To get the RAW url of a github image go to the image, take the url such as:
Original: https://github.com/owencorpening/images/blob/main/Pennybacker/Pennybacker.jpg

and replace "github.com" with "raw.githubusercontent"
and remove "blob" from between 'images' and 'main' which is the branch name

Raw: https://raw.githubusercontent.com/owencorpening/images/main/Pennybacker/Pennybacker.jpg