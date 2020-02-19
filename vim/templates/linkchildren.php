<?php if (is_object($contentpage) && ($contentpage->hasCombinedLinks() )) : ?>
<?php if ($contentpage->doLinkChildren() && $contentpage->getChildrenWithURI()) : ?>
<div id="linkchildren">
    <?php foreach ($contentpage->getChildrenWithURI() as $childpage) : ?>
    <div>
        <a href="<?php echo $childpage->getURI() ?>"><img src="/img/world.png" style="width:25px"></a>
        <a href="<?php echo $childpage->getURI() ?>"><?php echo htmlspecialchars($childpage->getTitle()) ?></a>
    </div>
    <?php endforeach ?>
</div>
<?php endif ?>
<?php endif ?>
