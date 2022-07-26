CREATE TABLE `warns` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `license` varchar(50) NOT NULL,
  `reason` text NOT NULL,
  `warnedby` varchar(50) NOT NULL,
  `warnedtime` bigint(20) NOT NULL DEFAULT unix_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `warns`
--
ALTER TABLE `warns`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `warns`
--
ALTER TABLE `warns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
COMMIT;