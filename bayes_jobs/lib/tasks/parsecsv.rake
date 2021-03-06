task :parsecsv => :environment do
	require 'csv'
	file_dir = Rails.root.join('lib', 'Katie_Skill_demo 2.csv')
	csv_text = File.read(file_dir)
	csv = CSV.parse(csv_text, :headers => true)

	csv.each do |row|
		j = JobsTest.new
    	j.title = row["title"]
    	j.interests_artistic = row["interests_artistic"]
    	j.interests_conventional = row["interests_conventional"]
    	j.interests_enterprising = row["interests_enterprising"]
    	j.interests_investigative = row["interests_investigative"]
    	j.interests_realistic = row["interests_realistic"]
    	j.interests_social = row["interests_social"]
    	j.skills_active_learning = row["skills_active_learning"]
    	j.skills_active_learning = row["skills_active_listening"]
    t.integer  "skills_complex_problem_solving"
    t.integer  "skills_coordination"
    t.integer  "skills_critical_thinking"
    t.integer  "skills_equipment_maintenance"
    t.integer  "skills_equipment_selection"
    t.integer  "skills_installation"
    t.integer  "skills_instructing"
    t.integer  "skills_judgment_and_decision_making"
    t.integer  "skills_learning_strategies"
    t.integer  "skills_management_of_financial_resources"
    t.integer  "skills_management_of_material_resources"
    t.integer  "skills_management_of_personnel_resources"
    t.integer  "skills_mathematics"
    t.integer  "skills_monitoring"
    t.integer  "skills_negotiation"
    t.integer  "skills_operation_and_control"
    t.integer  "skills_operation_monitoring"
    t.integer  "skills_operations_analysis"
    t.integer  "skills_persuasion"
    t.integer  "skills_programming"
    t.integer  "skills_quality_control_analysis"
    t.integer  "skills_reading_comprehension"
    t.integer  "skills_repairing"
    t.integer  "skills_science"
    t.integer  "skills_service_orientation"
    t.integer  "skills_social_perceptiveness"
    t.integer  "skills_speaking"
    t.integer  "skills_systems_analysis"
    t.integer  "skills_systems_evaluation"
    t.integer  "skills_technology_design"
    t.integer  "skills_time_management"
    t.integer  "skills_troubleshooting"
    t.integer  "skills_writing"
    t.string   "skills_dim"
    t.integer  "knowledge_administration_and_management"
    t.integer  "knowledge_biology"
    t.integer  "knowledge_building_and_construction"
    t.integer  "knowledge_chemistry"
    t.integer  "knowledge_clerical"
    t.integer  "knowledge_communications_and_media"
    t.integer  "knowledge_computers_and_electronics"
    t.integer  "knowledge_customer_and_personal_service"
    t.integer  "knowledge_design"
    t.integer  "knowledge_economics_and_accounting"
    t.integer  "knowledge_education_and_training"
    t.integer  "knowledge_engineering_and_technology"
    t.integer  "knowledge_english_language"
    t.integer  "knowledge_fine_arts"
    t.integer  "knowledge_food_production"
    t.integer  "knowledge_foreign_language"
    t.integer  "knowledge_geography"
    t.integer  "knowledge_history_and_archeology"
    t.integer  "knowledge_law_and_government"
    t.integer  "knowledge_mathematics"
    t.integer  "knowledge_mechanical"
    t.integer  "knowledge_medicine_and_dentistry"
    t.integer  "knowledge_personnel_and_human_resources"
    t.integer  "knowledge_philosophy_and_theology"
    t.integer  "knowledge_physics"
    t.integer  "knowledge_production_and_processing"
    t.integer  "knowledge_psychology"
    t.integer  "knowledge_public_safety_and_security"
    t.integer  "knowledge_sales_and_marketing"
    t.integer  "knowledge_sociology_and_anthropology"
    t.integer  "knowledge_telecommunications"
    t.integer  "knowledge_therapy_and_counseling"
    t.integer  "knowledge_transportation"
    t.integer  "education_level_required"
    t.string   "education_level_required_description"
    t.string   "o_net_soc_code_short"
    t.integer  "jobs1k_alabama"
    t.integer  "jobs1k_alaska"
    t.integer  "jobs1k_arizona"
    t.integer  "jobs1k_arkansas"
    t.integer  "jobs1k_california"
    t.integer  "jobs1k_colorado"
    t.integer  "jobs1k_connecticut"
    t.integer  "jobs1k_delaware"
    t.integer  "jobs1k_district_of_columbia"
    t.integer  "jobs1k_florida"
    t.integer  "jobs1k_georgia"
    t.integer  "jobs1k_hawaii"
    t.integer  "jobs1k_idaho"
    t.integer  "jobs1k_illinois"
    t.integer  "jobs1k_indiana"
    t.integer  "jobs1k_iowa"
    t.integer  "jobs1k_kansas"
    t.integer  "jobs1k_kentucky"
    t.integer  "jobs1k_louisiana"
    t.integer  "jobs1k_maine"
    t.integer  "jobs1k_maryland"
    t.integer  "jobs1k_massachusetts"
    t.integer  "jobs1k_michigan"
    t.integer  "jobs1k_minnesota"
    t.integer  "jobs1k_mississippi"
    t.integer  "jobs1k_missouri"
    t.integer  "jobs1k_montana"
    t.integer  "jobs1k_nebraska"
    t.integer  "jobs1k_nevada"
    t.integer  "jobs1k_new_hampshire"
    t.integer  "jobs1k_new_jersey"
    t.integer  "jobs1k_new_mexico"
    t.integer  "jobs1k_new_york"
    t.integer  "jobs1k_north_carolina"
    t.integer  "jobs1k_north_dakota"
    t.integer  "jobs1k_ohio"
    t.integer  "jobs1k_oklahoma"
    t.integer  "jobs1k_oregon"
    t.integer  "jobs1k_pennsylvania"
    t.integer  "jobs1k_rhode_island"
    t.integer  "jobs1k_south_carolina"
    t.integer  "jobs1k_south_dakota"
    t.integer  "jobs1k_tennessee"
    t.integer  "jobs1k_texas"
    t.integer  "jobs1k_utah"
    t.integer  "jobs1k_vermont"
    t.integer  "jobs1k_virginia"
    t.integer  "jobs1k_washington"
    t.integer  "jobs1k_west_virginia"
    t.integer  "jobs1k_wisconsin"
    t.integer  "jobs1k_wyoming"
    t.integer  "jobsquo_alabama"
    t.integer  "jobsquo_alaska"
    t.integer  "jobsquo_arizona"
    t.integer  "jobsquo_arkansas"
    t.integer  "jobsquo_california"
    t.integer  "jobsquo_colorado"
    t.integer  "jobsquo_connecticut"
    t.integer  "jobsquo_delaware"
    t.integer  "jobsquo_district_of_columbia"
    t.integer  "jobsquo_florida"
    t.integer  "jobsquo_georgia"
    t.integer  "jobsquo_hawaii"
    t.integer  "jobsquo_idaho"
    t.integer  "jobsquo_illinois"
    t.integer  "jobsquo_indiana"
    t.integer  "jobsquo_iowa"
    t.integer  "jobsquo_kansas"
    t.integer  "jobsquo_kentucky"
    t.integer  "jobsquo_louisiana"
    t.integer  "jobsquo_maine"
    t.integer  "jobsquo_maryland"
    t.integer  "jobsquo_massachusetts"
    t.integer  "jobsquo_michigan"
    t.integer  "jobsquo_minnesota"
    t.integer  "jobsquo_mississippi"
    t.integer  "jobsquo_missouri"
    t.integer  "jobsquo_montana"
    t.integer  "jobsquo_nebraska"
    t.integer  "jobsquo_nevada"
    t.integer  "jobsquo_new_hampshire"
    t.integer  "jobsquo_new_jersey"
    t.integer  "jobsquo_new_mexico"
    t.integer  "jobsquo_new_york"
    t.integer  "jobsquo_north_carolina"
    t.integer  "jobsquo_north_dakota"
    t.integer  "jobsquo_ohio"
    t.integer  "jobsquo_oklahoma"
    t.integer  "jobsquo_oregon"
    t.integer  "jobsquo_pennsylvania"
    t.integer  "jobsquo_rhode_island"
    t.integer  "jobsquo_south_carolina"
    t.integer  "jobsquo_south_dakota"
    t.integer  "jobsquo_tennessee"
    t.integer  "jobsquo_texas"
    t.integer  "jobsquo_utah"
    t.integer  "jobsquo_vermont"
    t.integer  "jobsquo_virginia"
    t.integer  "jobsquo_washington"
    t.integer  "jobsquo_west_virginia"
    t.integer  "jobsquo_wisconsin"
    t.integer  "jobsquo_wyoming"
    t.integer  "salary_alabama"
    t.integer  "salary_alaska"
    t.integer  "salary_arizona"
    t.integer  "salary_arkansas"
    t.integer  "salary_california"
    t.integer  "salary_colorado"
    t.integer  "salary_connecticut"
    t.integer  "salary_delaware"
    t.integer  "salary_district_of_columbia"
    t.integer  "salary_florida"
    t.integer  "salary_georgia"
    t.integer  "salary_hawaii"
    t.integer  "salary_idaho"
    t.integer  "salary_illinois"
    t.integer  "salary_indiana"
    t.integer  "salary_iowa"
    t.integer  "salary_kansas"
    t.integer  "salary_kentucky"
    t.integer  "salary_louisiana"
    t.integer  "salary_maine"
    t.integer  "salary_maryland"
    t.integer  "salary_massachusetts"
    t.integer  "salary_michigan"
    t.integer  "salary_minnesota"
    t.integer  "salary_mississippi"
    t.integer  "salary_missouri"
    t.integer  "salary_montana"
    t.integer  "salary_nebraska"
    t.integer  "salary_nevada"
    t.integer  "salary_new_hampshire"
    t.integer  "salary_new_jersey"
    t.integer  "salary_new_mexico"
    t.integer  "salary_new_york"
    t.integer  "salary_north_carolina"
    t.integer  "salary_north_dakota"
    t.integer  "salary_ohio"
    t.integer  "salary_oklahoma"
    t.integer  "salary_oregon"
    t.integer  "salary_pennsylvania"
    t.integer  "salary_rhode_island"
    t.integer  "salary_south_carolina"
    t.integer  "salary_south_dakota"
    t.integer  "salary_tennessee"
    t.integer  "salary_texas"
    t.integer  "salary_utah"
    t.integer  "salary_vermont"
    t.integer  "salary_virginia"
    t.integer  "salary_washington"
    t.integer  "salary_west_virginia"
    t.integer  "salary_wisconsin"
    t.integer  "salary_wyoming"
    t.integer  "salary_us"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at
		j.save

		puts 'just created new Job record for ' + j.title
	end
end