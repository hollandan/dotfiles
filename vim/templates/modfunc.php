    public function contentpage() {
        $this->setVar("contentpage", new ContentPage("contentpage"));
        $this->displayTemplate("contentpage");
    }
