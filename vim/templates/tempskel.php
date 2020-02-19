<?php $this->includeTemplate("header") ?>

<section id="<?php echo $contentpage->getTemplate() ?>" class="content">
    <?php if ($contentpage->getTitle()) : ?>
    <h1><?php echo htmlspecialchars($contentpage->getTitle()) ?></h1>
    <?php endif ?>

    <?php echo $contentpage->render() ?>
</section>

<?php $this->includeTemplate("footer") ?>
