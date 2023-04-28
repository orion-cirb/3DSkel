nb_slice= nSlices();
setSlice(round(nb_slice/2));
name1=getTitle();
run("Duplicate...", "duplicate");
name2=getTitle();
run("Difference of Gaussians", "  sigma1=25 sigma2=5 scaled enhance stack");
imageCalculator("Multiply create stack", name1, name2);

setSlice(round(nb_slice/2));
setAutoThreshold("Huang dark stack");
run("Convert to Mask", "method=Huang background=Dark black");

