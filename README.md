
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
To get the RAW url of a github image go to the image, right click and select "Copy Image Address"

My Free Image Search bookmarklet url:
javascript:(function(){var q=prompt('Search free image sites (Unsplash, Pexels, Pixabay):');if(!q)return;var sites='site:unsplash.com OR site:pexels.com OR site:pixabay.com';var url='https://www.google.com/search?q=%27+encodeURIComponent(q+%27 %27+sites)+%27&tbm=isch%27;window.location.href=url;})();

My Capture Image bookmarklet:
javascript:(function(){function toCamelCase(str){str=str.replace(/[^a-zA-Z0-9 ]/g,'').trim();return str.split(/\s+/).map((w,i)=>i==0?w.toLowerCase():w.charAt(0).toUpperCase()+w.slice(1).toLowerCase()).join(%27%27);}var pageTitle=document.title||%27newImage%27;var suggestedName=toCamelCase(pageTitle);var pageURL=document.location.href;var photographer=%27%27;if(document.querySelector(%27a[href^="/@"]%27)){photographer=document.querySelector(%27a[href^="/@"]%27).innerText.trim();}var data=JSON.stringify({name:suggestedName,url:pageURL,photographer:photographer});var ta=document.createElement(%27textarea%27);ta.value=data;document.body.appendChild(ta);ta.select();document.execCommand(%27copy%27);document.body.removeChild(ta);alert("Image info copied to clipboard!\n\nName: "+suggestedName+"\nPhotographer: "+photographer+"\nURL: "+pageURL);})();