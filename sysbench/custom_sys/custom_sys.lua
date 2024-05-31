local sysbench = require("sysbench")

-- Define custom options
sysbench.cmdline.options = {
    table_size = {"Number of rows per table", 10000},
    tables = {"Number of tables", 1},
    dataset = {"Name of the dataset", "testdb"}
}

-- Function to create tables
function create_tables()
    for i = 1, sysbench.opt.tables do
        local query = string.format([[
            CREATE TABLE %s.sbtest%d (
                id INT PRIMARY KEY AUTO_INCREMENT,
                k INT,
                c CHAR(120),
                pad CHAR(60)
            )
        ]], sysbench.opt.dataset, i)
        print("Creating table: " .. query)
        db_query(query)
    end
end

-- Function to load data
function load_data()
    for t = 1, sysbench.opt.tables do
        print(string.format("Inserting %d records into %s.sbtest%d", sysbench.opt.table_size, sysbench.opt.dataset, t))
        for i = 1, sysbench.opt.table_size do
            local query = string.format([[
                INSERT INTO %s.sbtest%d (k, c, pad) VALUES (%d, '%s', '%s')
            ]], sysbench.opt.dataset, t, sysbench.rand.default(1, sysbench.opt.table_size), sysbench.rand.string('a', 'z', 120), sysbench.rand.string('a', 'z', 60))
            db_query(query)
        end
    end
end

-- Sysbench event function (custom workload)
function event()
    local t = sysbench.rand.uniform(1, sysbench.opt.tables)
    local k = sysbench.rand.default(1, sysbench.opt.table_size)
    local query = string.format("SELECT c FROM %s.sbtest%d WHERE k=%d", sysbench.opt.dataset, t, k)
    db_query(query)
end

-- Main script entry points
sysbench.hooks = {
    -- Hook called by sysbench to initialize the script
    init = function()
        assert(sysbench.opt.threads > 0, "threads should be greater than 0")
    end,
    
    -- Hook called by sysbench to prepare the database
    prepare = function()
        create_tables()
        load_data()
    end
}

