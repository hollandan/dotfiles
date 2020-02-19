    public function +=+i($args = NULL) {
        if (count($args) == 0 || $args[0] == "") {
            $this->setVar("contentpage", new ContentPage("+=+i"));
            $this->displayTemplate("+=+i");
        } else {
            try {
                $ur = str_replace ( "-" , "_" , $args[0] );
                $this->setVar("contentpage", new ContentPage("+=+i-" . $ur ));
                $this->displayTemplate("+=+i");
            } catch (Exception $e) {
                $this->fileNotFound();
            }
        }
    }
