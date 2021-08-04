String sequencePath;
String stillPath;

public void save_file() {
  selectOutput("Specify file location and format (.jpg, .gif, .tif, .png) to save to:", "outputSelection");
}

public void outputSelection(File filePath) {
  if (filePath == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + filePath.getAbsolutePath());
    stillPath = filePath.getAbsolutePath();
    save(stillPath);
  }
}

public void record_sequence(boolean value) {
  if (value) {
    selectFolder("Select a location and filename (no extension) to save sequence to:", "outputFolderSelection");
  } else {
    record=false;
  }
}

public void outputFolderSelection(File folder) {
  if (folder == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + folder.getAbsolutePath());
    sequencePath = split(folder.getAbsolutePath(),'.')[0];
    record = true;
    sequenceIndex=0;
  }
}
