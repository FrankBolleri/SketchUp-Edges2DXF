# SketchUp Edges2DXF Plugin
Simple SketchUp plugin to export selected edges as line in DXF format

## Usage
### 1 Select what you want to export...
![Screenshot 2024-01-01 at 01 17 10](https://github.com/FrankBolleri/SketchUp-Edges2DXF/assets/26364299/431570a7-5fe8-4e79-90e3-3fc7f6331e02)

### 2 Click "Extensions" -> "Edges2DXF..."
![Screenshot 2024-01-01 at 01 18 44](https://github.com/FrankBolleri/SketchUp-Edges2DXF/assets/26364299/112ffc09-a1d5-4d8e-a568-6dcf4e0923b3)

### 3 Provide an output file path/name
![Screenshot 2024-01-01 at 01 20 08](https://github.com/FrankBolleri/SketchUp-Edges2DXF/assets/26364299/59d36429-5329-4ade-98fe-6fb5d801856f)

### 4 Choose if you want Z coordinates are included in data
![Screenshot 2024-01-01 at 01 20 32](https://github.com/FrankBolleri/SketchUp-Edges2DXF/assets/26364299/dd3ae341-75d3-4d76-8ec6-822edff30c7b)

## Difference between including Z coordinates or not
If you choose to include Z coordinates, any edge will be exported with the correct Z value.  
This mean that if you open the output DXF with AutoCAD and set a 3D view, you will see something similar to a "wireframe" composition of your object:
![Screenshot 2024-01-01 at 01 25 14](https://github.com/FrankBolleri/SketchUp-Edges2DXF/assets/26364299/f3014024-a703-4f38-8311-51444b1d68e2)

If instead you choose to do not include Z coordinates, any edge will be exported with Z value at 0, resulting in a flat representation.
![Screenshot 2024-01-01 at 01 28 03](https://github.com/FrankBolleri/SketchUp-Edges2DXF/assets/26364299/101840bd-9542-407c-b3a2-8d308036e7a9)

## Known limitations
I have created this plugin to fit my very basic need to export in DXF from SketchUp, because I was not able to find anything similar looking in the web.  
I know that the final result is full of overlapped lines (that can be removed in AutoCAD with OVERKILL command if all on the same Z) and just implemented using lines and not circles, arcs, polylines etc.  
But this result for my is enough: if someone else want to use it as base, fork it and create a more advanced DXF export plugin, feel free to do it.  

**For sure this plugin is provided AS IS and WITHOUT ANY WARRANTY - use at your own risk.**  

## References
I want to say thanks to Eneroth3 (https://github.com/Eneroth3) because it was using its plugins that i get inspired to try making one, even though I had never seen Ruby language before.  
Furthermore, as also mentioned in the code, a lot of my work is based on her SVG Exporter plugin (https://github.com/Eneroth3/eneroth-svg-exporter).  

Finally, I want to thank the authors of https://developer.sketchup.com/developers/example-extensions tutorial because it was by reading it that I understood how to start.  
