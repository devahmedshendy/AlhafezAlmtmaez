//
//  HomeScreen.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 05/12/2023.
//

import UIKit

final class HomeScreen: BaseScreen {

    // MARK: - Properties

    private lazy var vm: HomeScreenVM = .init()

    private var data: [EvaluationVM] { vm.data }
    private lazy var thisMonth: String = Date().yearMonth

    // MARK: - Subviews

    @IBOutlet weak var monthButton: UIButton!
    private lazy var datePicker: YearMonthDatePresenter = .init()
    @IBOutlet weak var displayEvaluationForMonthLabel: UILabel!
    @IBOutlet weak var noEvaluationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private lazy var refreshControl: UIRefreshControl = .init()

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupStrings()
        setupDynamicLayout()

        setupTableView()

        setupActions()

        monthButton.configuration?.title = thisMonth
        vm.getEvaluations(ofMonth: thisMonth)
    }

    // MARK: - Bindings

    override func setupVMBindingsOnViewDidLoad() {
        vm.$isLoading
            .sink { [weak self] isLoading in
                self?.isLoading = isLoading
                if isLoading {
                    self?.noEvaluationLabel.isHidden = true
                }
            }
            .store(in: &viewDidLoadBindings)

        vm.$isRefreshing
            .sink { [weak self] isRefreshing in
                if isRefreshing {
                    self?.noEvaluationLabel.isHidden = true
                } else {
                    self?.refreshControl.endRefreshing()
                }
            }
            .store(in: &viewDidLoadBindings)

        vm.$onToastMessage
            .assign(to: \.onToastMessage, on: self)
            .store(in: &viewDidLoadBindings)

        vm.$data
            .sink { [weak self] data in
                self?.noEvaluationLabel.isHidden = data.isEmpty == false
                self?.tableView.reloadData()
            }
            .store(in: &viewDidLoadBindings)
    }

    // MARK: - Actions

    private func setupActions() {
        refreshControl.addTarget(
            self,
            action: #selector(doRefresh),
            for: .valueChanged
        )

        monthButton.addTarget(
            self,
            action: #selector(doOpenYearMonthPicker),
            for: .touchUpInside
        )

        datePicker.onCancel = { [weak self] in
            self?.datePicker.doHidePicker()
            self?.datePicker.removeFromSuperview()
        }
        datePicker.onPick = { [weak self] pickedDate, formatted in
            self?.monthButton.configuration?.title = formatted
            self?.datePicker.doHidePicker()
            self?.datePicker.removeFromSuperview()
            self?.vm.getEvaluations(ofMonth: formatted)
        }
    }

    @objc private func doRefresh() {
        vm.refreshEvaluations(
            ofMonth: monthButton.configuration?.title ?? thisMonth
        )
    }

    @objc private func doOpenYearMonthPicker() {
        view.addSubview(datePicker)
        datePicker.doShowPicker()
    }
}

// MARK: - UITableViewDelegate

extension HomeScreen: UITableViewDelegate {

}

// MARK: - UITableViewDataSource

extension HomeScreen: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            EvaluationTableCell.self,
            for: indexPath
        )

        cell.data = data[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.dequeueReusableCell(EvaluationsTableHeaderCell.self)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .dynamicToWidth(40)
    }
}

// MARK: - View Setup

extension HomeScreen {
    private func setupStrings() {
        self.navigationItem.title = .text.Home
    }

    private func setupDynamicLayout() {
        displayEvaluationForMonthLabel.font = .avenirArabic_800(size: 16)
        noEvaluationLabel.font = .avenirArabic_500(size: 14)
        monthButton.titleLabel?.font = .avenirArabic_500(size: 16)
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.refreshControl = refreshControl
        tableView.sectionHeaderTopPadding = 0
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension

        tableView.registerCellNib(EvaluationTableCell.self)
        tableView.registerCellNib(EvaluationsTableHeaderCell.self)
    }
}
