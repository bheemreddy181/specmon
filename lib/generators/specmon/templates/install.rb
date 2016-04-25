class <%= migration_class_name %> < ActiveRecord::Migration
  def change
    create_table "specmon_builds", force: :cascade do |t|
      t.string   "project_id"
      t.string   "vcs_revision"
      t.string   "build_num"
      t.datetime "started_at"
      t.datetime "stopped_at"
      t.integer  "build_time"
      t.integer  "queue_time"
      t.float    "run_time_sum"
      t.float    "run_time_max"
      t.float    "run_time_median"
      t.float    "run_time_mean"
      t.integer  "examples_count"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "status"
    end

    add_index "specmon_builds", ["project_id"], name: "index_specmon_builds_on_project_id", using: :btree
    add_index "specmon_builds", ["project_id", "build_num"], name: "index_specmon_builds_on_project_id_and_build_num", unique: true, using: :btree
    add_index "specmon_builds", ["vcs_revision"], name: "index_specmon_builds_on_vcs_revision", using: :btree

    create_table "specmon_examples", force: :cascade do |t|
      t.string   "file"
      t.string   "name"
      t.float    "run_time"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "digest"
      t.integer  "line_number"
      t.integer  "build_id"
      t.string   "owner"
      t.boolean  "success"
    end

    add_index "specmon_examples", ["build_id", "success"], name: "index_specmon_examples_on_build_id_and_success", using: :btree
    add_index "specmon_examples", ["build_id"], name: "index_specmon_examples_on_build_id", using: :btree
    add_index "specmon_examples", ["digest"], name: "index_specmon_examples_on_digest", using: :btree
    add_index "specmon_examples", ["owner"], name: "index_specmon_examples_on_owner", using: :btree
    add_index "specmon_examples", ["success"], name: "index_specmon_examples_on_success", using: :btree
  end
end
