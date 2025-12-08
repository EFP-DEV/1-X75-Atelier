START TRANSACTION;

INSERT INTO operator (username, password, email, last_login, is_active)
VALUES 
('ada', '$2y$10$wH1tEeR9d8YpVJ/kuT2Ehe9IhcGdW8LZcK7M8bzKHc9zDey.XpXiS', 'ada@lovelace.tech', '1970-11-27 00:00:00', 0),
('grace', '$2y$10$A8j9kL0mN1oP2qR3sT4uV5wX6yZ7aB8cD9eF0gH1iJ2kL3mN4oPqRs', 'grace@hopper.tech', '1992-01-01 00:00:00', 0),
('alan', '$2y$10$Z3x4c5v6b7n8m9q0w1e2r3t4y5u6i7o8p9a0s1d2f3g4h5j6k7l8m', 'alan@turing.ai', '1970-06-07 00:00:00', 0),
('dennis', '$2y$10$Q1w2e3r4t5y6u7i8o9p0a1s2d3f4g5h6j7k8l9z0x1c2v3b4n5m6O', 'dennis@ritchie.dev', '2011-10-12 00:00:00', 0),
('bill', '$2y$10$P0o9i8u7y6t5r4e3w2q1a2s3d4f5g6h7j8k9l0z1x2c3v4b5n6m7L', 'bill@gates.com', '2024-12-10 09:05:55', 1),
('charles', '$2y$10$M1n2b3v4c5x6z7l8k9j0h1g2f3d4s5a6p7o8i9u0y1t2r3e4w5q6R', 'charles@babbage.tech', '1970-10-18 00:00:00', 0),
('linus', '$2y$10$N9m8b7v6c5x4z3l2k1j0h9g8f7d6s5a4p3o2i1u0y9t8r7e6w5q4T', 'linus@torvalds.org', '2024-09-18 16:22:10', 1),
('paul', '$2y$10$L0k9j8h7g6f5d4s3a2p1o0i9u8y7t6r5e4w3q2z1x0c9v8b7n6m5N', 'paul@otlet.info', '1970-12-15 00:00:00', 0),
('tim', '$2y$10$R5e4w3q2z1x0c9v8b7n6m5L4k3j2h1g0f9d8s7a6p5o4i3u2y1t0S', 'tim@bernerslee.org', '2025-02-28 22:10:05', 1),
('radia', '$2y$10$T1r2e3w4q5z6x7c8v9b0n1m2L3k4j5h6g7f8d9s0a1p2o3i4u5y6I', 'radia@perlman.tech', '2024-10-31 07:30:00', 1);


INSERT INTO tag (operator_id, name, slug)
VALUES
(1, 'Programming', 'programming'),
(2, 'Web Development', 'web-development'),
(3, 'Algorithms', 'algorithms'),
(4, 'Data Structures', 'data-structures'),
(5, 'Cybersecurity', 'cybersecurity'),
(6, 'Cloud Computing', 'cloud-computing'),
(7, 'Machine Learning', 'machine-learning'),
(8, 'Databases', 'databases'),
(9, 'Networking', 'networking'),
(10, 'Software Engineering', 'software-engineering');


INSERT INTO item (operator_id, title, slug, description, content, image, price, stock, status)
VALUES
(1, 'Mechanical Keyboard', 'mechanical-keyboard', 'A tactile keyboard that clicks with every keystroke.', 'This keyboard isn’t just key—it’s the typecast star of your desktop.', 'keyboard.jpg', 99.99, 50, 'published'),
(2, 'Sit & Code Throne', 'sit-code-throne', 'Not your average chair—built to seat your bugs and support your byte-sized ideas.', 'Where comfort meets code: take a seat and let your errors fall off your throne.', 'dev-chair.jpg', 499.99, 20, 'published'),
(3, 'Noise-Cancelling Headphones', 'noise-cancelling-headphones', 'Headphones that silence distractions and amplify your code’s voice.', 'Ideal for debugging in peace—these headphones truly speak volumes.', 'headphones.jpg', 199.99, 30, 'published'),
(4, 'Byte Me Laptop', 'byte-me-laptop', 'This high-performance laptop is so fast, it’ll byte off more than you can chew.', 'Engineered to compile code at lightning speed—it’s a real “tech”nical marvel.', 'laptop.jpg', 1299.99, 10, 'published'),
(5, 'Cloud Storage Subscription', 'cloud-storage-subscription', 'Store your code in the clouds, where your data never falls down.', 'Backup your projects with a service that’s always above the rest—no rainy days here!', 'cloud.jpg', 9.99, 100, 'published'),
(6, 'Wireless Charging Dock', 'wireless-charging-dock', 'A dock that charges your devices wire-free and error-free.', 'Keep your gadgets powered up without any strings attached—say goodbye to deadlocks!', 'charging-dock.jpg', 39.99, 50, 'draft'),
(7, '4K Monitor', '4k-monitor', 'A monitor so sharp, it renders your bugs pixel-perfectly out of sight.', 'Enjoy vivid visuals and ample screen real estate to display your code in style—resolution guaranteed!', 'monitor.jpg', 299.99, 15, 'published'),
(8, 'Retro Gaming Console', 'retro-gaming-console', 'A console that’s a blast from the past—perfect for when you need to reboot your brain.', 'Unwind with vintage games and relive the golden era of arcade coding—fun that never crashes.', 'console.jpg', 149.99, 25, 'archived'),
(9, 'Bluetooth Debug Speaker', 'bluetooth-debug-speaker', 'A speaker that plays tunes and drops witty bug fixes.', 'Let it amplify your debugging sessions with clever error messages—volume control for your soul.', 'debug-speaker.jpg', 79.99, 40, 'published'),
(10, 'Smartwatch for Developers', 'smartwatch-for-developers', 'A smartwatch that tracks time and code commits with pinpoint precision.', 'Stay connected on the go and never miss a beat, commit, or coffee break—wrist tech at its finest.', 'dev-smartwatch.jpg', 249.99, 30, 'published');

INSERT INTO collection (operator_id, name, description, is_public)
VALUES
(1, 'Favorites', 'A curated list of must-haves, handpicked by our discerning visitor.', 1),
(2, 'Wishlist', 'Dream big – these items are goals on a shopping list.', 0),
(3, 'Cart', 'Not just a cart; it’s a trolley of aspirations.', 1),
(4, 'Impulse Buys', 'Because sometimes you just can’t resist a good deal.', 0),
(5, 'Gifts', 'Ideas for when you need to impress someone special.', 1),
(6, 'Clearance Finds', 'The bargain bin never looked so chic.', 0),
(7, 'Tech Toolbox', 'All the gadgets and gizmos that make life fun.', 1),
(8, 'Book Nook', 'A collection for the literary and the witty alike.', 0),
(9, 'Home Essentials', 'Everything you need for a cozy yet clever abode.', 1),
(10, 'Oddities', 'A collection of things that are strangely irresistible.', 0);

INSERT INTO search (operator_id, query, results_count, session_id)
VALUES
(1, '/search?query=quirky+office+chairs+for+creative+minds&tag_id=7,3', 7, 'a1b2c3d4e5f67890123456789abcdef0'),
(2, '/search?query=vintage+gadgets+with+modern+flair&tag_id=4,8', 5, 'f0e1d2c3b4a5968778695a4b3c2d1e0f'),
(3, '/search?query=eco-friendly+products+that+don’t+break+the+bank&tag_id=5,9', 12, '1234567890abcdef1234567890abcdef'),
(4, '/search?query=smart+devices+with+a+sense+of+humor', 9, 'fedcba0987654321fedcba0987654321'),
(5, '/search?query=books+that+make+you+laugh+and+think&tag_id=2,10', 8, '0f1e2d3c4b5a69788796a5b4c3d2e1f0'),
(6, '/search?query=cutting-edge+tech+for+gadget+geeks&tag_id=3,7', 15, 'abcdef0123456789abcdef0123456789'),
(7, '/search?query=retro+gaming+consoles+for+a+blast+from+the+past&tag_id=8', 6, '11223344556677889900aabbccddeeff'),
(8, '/search?query=must-have+travel+accessories+with+personality&tag_id=6,9', 4, 'ffeeddccbbaa00998877665544332211'),
(9, '/search?query=art+pieces+that+spark+conversation&tag_id=9,1', 10, '13579bdf02468ace13579bdf02468ace'),
(10, '/search?query=unique+home+decor+for+the+unconventional&tag_id=10,2', 11, 'eca86420bdf13579eca86420bdf13579');

INSERT INTO message (name, email, subject, content, is_read, is_spam, operator_id, ip_address)
VALUES
('Lucy L.', 'lucy.l@example.com', 'Infinite Loop of Errors', 'My website is caught in an infinite loop—any tips to break the recursion?', 0, 0, 1, '198.51.100.10'),
('Mark T.', 'mark.t@example.com', 'CSS Not Found', 'My layout is all over the place—seems like my CSS file got lost in the cloud!', 1, 0, 2, '198.51.100.11'),
('Nina P.', 'nina.p@example.com', '404 Error on My Code', 'My script can’t seem to find a critical element—getting a 404 on function calls!', 0, 0, 3, '198.51.100.12'),
('Oscar Q.', 'oscar.q@example.com', 'Database Disaster', 'My queries are returning nothing but errors. Is my database on vacation?', 1, 0, 4, '198.51.100.13'),
('Pam S.', 'pam.s@example.com', 'Wishlist Widget Woes', 'My wishlist widget isn’t rendering properly—it clearly needs a developer’s magic touch.', 0, 0, 5, '198.51.100.14'),
('Quinn R.', 'quinn.r@example.com', 'API Timeout Blues', 'The API is timing out more than my lunch break—could use some advice on retry logic!', 1, 0, 6, '198.51.100.15'),
('Rose U.', 'rose.u@example.com', 'Bootstrap Breakdown', 'My responsive design just broke at 768px. Bootstrap, are you even listening?', 0, 0, 7, '198.51.100.16'),
('Sam V.', 'sam.v@example.com', 'Smartwatch Sync Issues', 'My smartwatch isn’t syncing with my dev tools—am I missing a critical update?', 1, 0, 8, '198.51.100.17'),
('Tina W.', 'tina.w@example.com', 'Browser Compatibility Cringe', 'My site looks bizarre on Internet Explorer—time to fully embrace modern standards!', 0, 0, 9, '198.51.100.18'),
('Victor X.', 'victor.x@example.com', 'Git Commit Gone Wild', 'I accidentally pushed a bug to production—Git blame is real and unforgiving!', 1, 0, 10, '198.51.100.19');


INSERT INTO item_tag (item_id, tag_id)
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


INSERT INTO collection_item (collection_id, item_id, quantity)
VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1),
(1, 2, 2),
(2, 3, 1),
(3, 4, 2),
(4, 5, 1),
(5, 6, 3),
(6, 7, 1),
(7, 8, 2),
(8, 9, 1),
(9, 10, 1),
(10, 1, 1),
(1, 3, 1),
(2, 4, 1),
(3, 5, 1),
(4, 6, 1),
(5, 7, 1);

COMMIT;
