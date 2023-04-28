//traitement image
setBatchMode(true);

Dialog.create("Réglages");
Dialog.addNumber("Gaussian Nuclei ratio1:",10);
Dialog.addNumber("Gaussian Nuclei ratio2:",2);
Dialog.addNumber("Gaussian Phaloidin ratio1:",20);
Dialog.addNumber("Gaussian Phaloidin ratio1:",5);
Dialog.addNumber("Start at picture:",1);
Dialog.show();
Nratio1=Dialog.getNumber();
Nratio2=Dialog.getNumber();
Phalratio1=Dialog.getNumber();
Phalratio2=Dialog.getNumber();
Pictstart=Dialog.getNumber();


var pixelSize = 0.537;
var nbChannel = 0;	// number of channels
var channelName;	// array containing channel name
var zStep = 1;		// z depth
var zSize;		// Z step
var nStage;		// positions

function find_nd_info(ndFile) { // Find channel and z step infos 
	lines = split(File.openAsString(inDir+ndFile), "\n"); 
		for (i = 0; i < lines.length; i++) {
			if (startsWith(lines[i],"\"NWavelengths\"")) {
				nWaves = split(lines[i],", ");
				nbChannel = parseInt(nWaves[1]);
				wave = newArray(nbChannel);
				var nbWave = 1;
				while(!startsWith(lines[i],"\"WaveName"+nbChannel+"\"")) {
					i++;
					if (startsWith(lines[i],"\"WaveName"+parseInt(nbWave)+"\"")) {
						waveLine = split(lines[i],"\"");
						waveName = "_w"+parseInt(nbWave);
						wave[nbWave-1] = waveName+waveLine[2];
						nbWave++;
					}
				}
			}
			else if (startsWith(lines[i],"\"NZSteps\"")){
				Z = split(lines[i],"");
				zStep = parseInt(Z[1]);
			}
			else if (startsWith(lines[i],"\"ZStepSize\"")){
				Z = split(lines[i],"");
				zSize = parseInt(Z[1]);
			}
			else if (startsWith(lines[i],"\"NStagePositions\"")){
				stage = split(lines[i],",");
				nStage = parseInt(stage[1]);
			}
		}
		return wave;
}



inDir = getDirectory("Images folder");
outDir = getDirectory("Output images folder");
list = getFileList(inDir);

for (f = 0; f < list.length; f++) {
	if (endsWith(list[f],".nd")) {
		fileName = substring(list[f],0,indexOf(list[f],".nd"));
		waveName = find_nd_info(list[f]);
		for (s = Pictstart; s <= nStage; s++) {
			
			// process DAPI
			open(inDir+fileName + waveName[0] + "_s" + s + ".TIF");
			run("Mean 3D...", "x=2 y=2 z=2");
			run("Difference of Gaussians", "  sigma1=&Nratio1 sigma2=&Nratio2 stack");
			setAutoThreshold("Moments dark");
			setOption("BlackBackground", true);
			run("Convert to Mask", "stack");
			run("Options...", "iterations=1 count=1 black edm=Overwrite do=Open stack");
			imageDAPI = getTitle();
			run("3D OC Options", "dots_size=5 font_size=10 store_results_within_a_table_named_after_the_image_(macro_friendly) redirect_to=none");
			run("3D Objects Counter", "threshold=128 slice=30 min.=10 max.=988308480 centroids");
			
			selectImage(imageDAPI);
			close();
			objimageDAPI = getTitle();
			selectImage(objimageDAPI);
			run("Make Binary", "method=Otsu background=Dark calculate black");
			
			// process phaloidine
			open(inDir+fileName + waveName[1] + "_s" + s + ".TIF");
			
			setVoxelSize(pixelSize,pixelSize,5,"microns");
			run("Difference of Gaussians", "  sigma1=&Phalratio1 sigma2=&Phalratio2 stack");
			setAutoThreshold("Li dark");
			setOption("BlackBackground", true);
			run("Convert to Mask", "stack");
			imagePhal = getTitle();
			run("Options...", "iterations=1 count=1 black edm=Overwrite do=Open stack");
			run("3D OC Options", "volume integrated_density dots_size=5 font_size=10 store_results_within_a_table_named_after_the_image_(macro_friendly)  redirect_to=&objimageDAPI");
			run("3D Objects Counter", "threshold=128 slice=30 min.=10 max.=988308480 objects statistics summary");			
			objimagePhal = getTitle();
			selectImage(imagePhal);
			close();
			selectWindow("Statistics for " + imagePhal + " redirect to " + objimageDAPI);
			saveAs("Results", outDir + imagePhal + ".csv");
			run("Close");
			
			selectImage(objimageDAPI);
			saveAs("TIF",outDir + objimagePhal);
			close();
			selectImage(objimagePhal);
			saveAs("TIF",outDir + imageDAPI);
			close();
		}
	}
}
		




