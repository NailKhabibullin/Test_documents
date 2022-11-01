Test Doocuments

1. Для добавления блока поиска в витрине магазина в окне "Document":

Предворительно редактирвать /app/addons/test_documents/schemas/block_manager/blocks.post.php
Закомментировать строки 13. и 19.

Далее:

 - В панели Администратора пройти в Меню: Design -> Layotus -> Manage blocks
 - В разделе окна "Manage blocks" в правом верхнм углу нажимаем "+"
 - Находим иконку "_block_documents_search_block" и добавляем.
 - Вводим данные, сохраняем.
 - В панели Администратора пройти в Меню: Design -> Layotus -> Layotus
 - В разделе окна "Content" под окном "Main Content" нажимаем "+" -> "Add block"
 - Находим нужный нам блок и добавляем его.

 Далее:

Снова редактирвать /app/addons/test_documents/schemas/block_manager/blocks.post.php
Раскомментировать строки 13. и 19. 

2. Для добавления меню "Documents" в витрину магазина:
  - В панели Администратора пройти в Меню: Design -> Menus
  - Зайти в Меню, отвечающую за Top Menu в витрине магазина
  - В открывшемся окне в правом верхнем углу нажать "+" (Add item)
  - Заполнить следующие данные:
   
    Parent item:      - Root level -
    Name:             Documents
    Pos.:             Ввести необходимую позицию
    URL:              index.php?dispatch=test_documents.documents
    Generate submenu: None

 - Сохранить
 