START TRANSACTION;

-- ============================================================
-- operator
-- ============================================================

INSERT INTO `operator` (`id`, `password`, `email`, `last_login`, `is_active`)
VALUES
(1,  '$2y$10$wH1tEeR9d8YpVJ/kuT2Ehe9IhcGdW8LZcK7M8bzKHc9zDey.XpXiS', 'ada@lovelace.tech',     '1970-11-27 00:00:00', 0),
(2,  '$2y$10$A8j9kL0mN1oP2qR3sT4uV5wX6yZ7aB8cD9eF0gH1iJ2kL3mN4oPqRs', 'grace@hopper.tech',    '1992-01-01 00:00:00', 0),
(3,  '$2y$10$Z3x4c5v6b7n8m9q0w1e2r3t4y5u6i7o8p9a0s1d2f3g4h5j6k7l8m', 'alan@turing.ai',       '1970-06-07 00:00:00', 0),
(4,  '$2y$10$Q1w2e3r4t5y6u7i8o9p0a1s2d3f4g5h6j7k8l9z0x1c2v3b4n5m6O', 'dennis@ritchie.dev',   '2011-10-12 00:00:00', 0),
(5,  '$2y$10$P0o9i8u7y6t5r4e3w2q1a2s3d4f5g6h7j8k9l0z1x2c3v4b5n6m7L', 'bill@gates.com',       '2024-12-10 09:05:55', 1),
(6,  '$2y$10$M1n2b3v4c5x6z7l8k9j0h1g2f3d4s5a6p7o8i9u0y1t2r3e4w5q6R', 'charles@babbage.tech', '1970-10-18 00:00:00', 0),
(7,  '$2y$10$N9m8b7v6c5x4z3l2k1j0h9g8f7d6s5a4p3o2i1u0y9t8r7e6w5q4T', 'linus@torvalds.org',   '2024-09-18 16:22:10', 1),
(8,  '$2y$10$L0k9j8h7g6f5d4s3a2p1o0i9u8y7t6r5e4w3q2z1x0c9v8b7n6m5N', 'paul@otlet.info',      '1970-12-15 00:00:00', 0),
(9,  '$2y$10$R5e4w3q2z1x0c9v8b7n6m5L4k3j2h1g0f9d8s7a6p5o4i3u2y1t0S', 'tim@bernerslee.org',   '2025-02-28 22:10:05', 1),
(10, '$2y$10$T1r2e3w4q5z6x7c8v9b0n1m2L3k4j5h6g7f8d9s0a1p2o3i4u5y6I', 'radia@perlman.tech',   '2024-10-31 07:30:00', 1);

-- ============================================================
-- tag
-- category + theme are represented as tags in this schema
-- parent_tag_id left NULL for simplicity
-- ============================================================

INSERT INTO `tag` (`id`, `operator_id`, `parent_tag_id`, `name`, `slug`)
VALUES
(1, 1, NULL, 'Programming',          'programming'),
(2, 8, NULL, 'Web Development',      'web-development'),
(3, 1, NULL, 'Algorithms',           'algorithms'),
(4, 4, NULL, 'Data Structures',      'data-structures'),
(5, 1, NULL, 'Cybersecurity',        'cybersecurity'),
(6, 6, NULL, 'Cloud Computing',      'cloud-computing'),
(7, 1, NULL, 'Machine Learning',     'machine-learning'),
(8, 8, NULL, 'Databases',            'databases'),
(9, 1, NULL, 'Networking',           'networking'),
(10, 5, NULL, 'Software Engineering','software-engineering');

-- ============================================================
-- collection
-- ============================================================

INSERT INTO `collection` (`id`, `operator_id`, `name`, `description`, `is_public`)
VALUES
(1,  1, 'Favorites',        'A curated list of must-haves, handpicked by our discerning visitor.', 1),
(2,  2, 'Wishlist',         'Dream big – these items are goals on a shopping list.', 0),
(3,  3, 'Cart',             'Not just a cart; it is a trolley of aspirations.', 1),
(4,  4, 'Impulse Buys',     'Because sometimes you just cannot resist a good deal.', 0),
(5,  5, 'Gifts',            'Ideas for when you need to impress someone special.', 1),
(6,  6, 'Clearance Finds',  'The bargain bin never looked so chic.', 0),
(7,  7, 'Tech Toolbox',     'All the gadgets and gizmos that make life fun.', 1),
(8,  8, 'Book Nook',        'A collection for the literary and the witty alike.', 0),
(9,  8, 'Home Essentials',  'Everything you need for a cozy yet clever abode.', 1),
(10, 8, 'Oddities',         'A collection of things that are strangely irresistible.', 0);

-- ============================================================
-- message
-- structure only allows operator_id
-- ============================================================

INSERT INTO `message` (`id`, `operator_id`)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- ============================================================
-- item
-- category_tag_id and theme_tag_id are required
-- avatar is the correct column name
-- ============================================================

INSERT INTO `item`
(`id`, `operator_id`, `category_tag_id`, `theme_tag_id`, `title`, `slug`, `description`, `content`, `avatar`)
VALUES
(1,  1, 1, 2,  'Mechanical Keyboard',         'mechanical-keyboard',         'A tactile keyboard that clicks with every keystroke.',                         'This keyboard is the typecast star of your desktop.',                                                'keyboard.jpg'),
(2,  6, 2, 10, 'Sit and Code Throne',         'sit-code-throne',             'Not your average chair—built to seat your bugs and support your ideas.',      'Where comfort meets code: take a seat and let your errors fall off your throne.',                   'dev-chair.jpg'),
(3,  3, 3, 8,  'Noise-Cancelling Headphones', 'noise-cancelling-headphones', 'Headphones that silence distractions and amplify your code’s voice.',          'Ideal for debugging in peace—these headphones truly speak volumes.',                                'headphones.jpg'),
(4,  2, 2, 1,  'Byte Me Laptop',              'byte-me-laptop',              'This high-performance laptop is so fast, it will byte off more than you can chew.', 'Engineered to compile code at lightning speed.',                                               'laptop.jpg'),
(5,  5, 6, 9,  'Cloud Storage Subscription',  'cloud-storage-subscription',  'Store your code in the clouds, where your data never falls down.',             'Backup your projects with a service that is always above the rest.',                                'cloud.jpg'),
(6,  6, 10, 6, 'Wireless Charging Dock',      'wireless-charging-dock',      'A dock that charges your devices wire-free and error-free.',                   'Keep your gadgets powered up without any strings attached.',                                        'charging-dock.jpg'),
(7,  1, 8, 7,  '4K Monitor',                  '4k-monitor',                  'A monitor so sharp, it renders your bugs pixel-perfectly out of sight.',       'Enjoy vivid visuals and ample screen real estate to display your code in style.',                   'monitor.jpg'),
(8,  8, 1, 8,  'Retro Gaming Console',        'retro-gaming-console',        'A console that is a blast from the past—perfect for when you need to reboot your brain.', 'Unwind with vintage games and relive the golden era of arcade coding.',                      'console.jpg'),
(9,  8, 9, 10, 'Bluetooth Debug Speaker',     'bluetooth-debug-speaker',     'A speaker that plays tunes and drops witty bug fixes.',                        'Let it amplify your debugging sessions with clever error messages.',                                'debug-speaker.jpg'),
(10, 8, 2, 7,  'Smartwatch for Developers',   'smartwatch-for-developers',   'A smartwatch that tracks time and code commits with pinpoint precision.',      'Stay connected on the go and never miss a beat, commit, or coffee break.',                         'dev-smartwatch.jpg');

-- ============================================================
-- search
-- correct column name is result_count
-- no session_id column in structure
-- ============================================================

INSERT INTO `search` (`id`, `query`, `result_count`)
VALUES
(1,  '/search?query=quirky+office+chairs+for+creative+minds&tag_id=7,3',              7),
(2,  '/search?query=vintage+gadgets+with+modern+flair&tag_id=4,8',                     5),
(3,  '/search?query=eco-friendly+products+that+do+not+break+the+bank&tag_id=5,9',     12),
(4,  '/search?query=smart+devices+with+a+sense+of+humor',                               9),
(5,  '/search?query=books+that+make+you+laugh+and+think&tag_id=2,10',                   8),
(6,  '/search?query=cutting-edge+tech+for+gadget+geeks&tag_id=3,7',                    15),
(7,  '/search?query=retro+gaming+consoles+for+a+blast+from+the+past&tag_id=8',         6),
(8,  '/search?query=must-have+travel+accessories+with+personality&tag_id=6,9',         4),
(9,  '/search?query=art+pieces+that+spark+conversation&tag_id=9,1',                    10),
(10, '/search?query=unique+home+decor+for+the+unconventional&tag_id=10,2',             11);

-- ============================================================
-- item_tag
-- ============================================================

INSERT INTO `item_tag` (`item_id`, `tag_id`)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 6),
(6, 7),
(7, 8),
(8, 9),
(9, 10),
(10, 1),
(1, 3),
(2, 4),
(3, 5),
(4, 6),
(5, 7);

-- ============================================================
-- collection_item
-- structure has no quantity column
-- ============================================================

INSERT INTO `collection_item` (`collection_id`, `item_id`)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 6),
(6, 7),
(7, 8),
(8, 9),
(9, 10),
(10, 1),
(1, 3),
(2, 4),
(3, 5),
(4, 6),
(5, 7);

COMMIT;
